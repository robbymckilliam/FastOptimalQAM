package qam.pat;

import java.util.Arrays;
import pubsim.Complex;
import pubsim.IndexedDouble;
import pubsim.VectorFunctions;
import qam.QAMReceiver;
import qam.T2LogTSubOptimalV3;

/**
 * Dan's suboptimal T2LogT noncoherent reciever that is modified to work
 * with a known sequence of PAT symbols.  The order of hte sequence is
 * esimated along with the data and channel.
 * @author Robby
 */
public class PilotSequencedT2LogTSuboptimal extends T2LogTSubOptimalV3
        implements QAMReceiver {

    /**
     * Default, numL = 20
     */
    public PilotSequencedT2LogTSuboptimal() {
        numL = 20;
    }

    /**
     * Set number of lines used in the line search
     */
    public PilotSequencedT2LogTSuboptimal(double numL) {
        this.numL = numL;
    }

    /** Overide Nearest Neigbour to work with the pilot translation */
    @Override
    protected void NN(double[] x, double[] y) {     
        
        PATseq.setPosition(0);
        Complex PAT = PATseq.current();
        for (int i = 0; i < x.length; i += 2) {
            y[i] = Math.max(Math.min(M - 1, 2 * Math.round(((x[i] - PAT.re()) + 1) / 2) - 1), -M + 1);
            y[i] += PAT.re();
            PAT = PATseq.next();
        }
        
        PATseq.setPosition(0);
        PAT = PATseq.current();
        for (int i = 1; i < x.length; i += 2) {
            y[i] = Math.max(Math.min(M - 1, 2 * Math.round(((x[i] - PAT.im()) + 1) / 2) - 1), -M + 1);
            y[i] += PAT.im();
            PAT = PATseq.next();
        }
    }

    /**
     * Set number of QAM signals to use for
     * estimating the channel
     */
    @Override
    public void setT(int T) {
        this.T = T;

        y1 = new double[2 * T];
        y2 = new double[2 * T];
        x = new double[2 * T];
        xopt = new double[2 * T];
        d = new double[2 * T];

        dreal = new double[T];
        dimag = new double[T];

        sorted = new IndexedDouble[2 * T * (M - 1)];
        for (int m = 0; m < sorted.length; m++) {
            sorted[m] = new IndexedDouble();
        }
    }

    /** Decode the QAM signal */
    @Override
    public void decode(double[] rreal, double[] rimag) {
        if (rreal.length != T) {
            setT(rreal.length);
        }

        createPlane(rreal, rimag, y1, y2);

        double Lopt = Double.NEGATIVE_INFINITY;
        double thetaopt = 0.0, dopt = 0.0;
        double thetastep = 2 * Math.PI / numL;
        for (double theta = 0.0; theta < 2 * Math.PI; theta += thetastep) {

            //calculate the search line
            double a = Math.cos(theta);
            double b = Math.sin(theta);
            for (int i = 0; i < 2 * T; i++) {
                d[i] = a * y1[i] + b * y2[i];
            }
            
            PATseq.setPosition(0);
            Complex PAT = PATseq.current();

            //setup sorted map
            int sortcount = 0;
            for (int j = 0; j < 2 * T; j++) {

                double pn;
                if (j % 2 == 0) {
                    pn = PAT.re();
                } else {
                    pn = PAT.im();
                    PAT = PATseq.next();
                }

                for (double m = -M + 2 + pn; m <= M - 2 + pn; m += 2.0) {
                    if (Math.signum(m) == Math.signum(d[j])) {
                        sorted[sortcount].value = m / d[j];
                        sorted[sortcount].index = j;
                        sortcount++;
                    }
                }
            }
            Arrays.sort(sorted, 0, sortcount);

            //calculate the start point
            for (int i = 0; i < 2 * T; i++) {
                x[i] = 0.0;
            }
            NN(x, x);

            //System.out.println(VectorFunctions.print(x));

            //setup likelihood variables
            double beta = VectorFunctions.sum2(x);
            double ar = 0.0, ai = 0.0;
            for (int j = 0; j < T; j++) {
                ar += x[2 * j] * rreal[j] + x[2 * j + 1] * rimag[j];
                ai += x[2 * j] * rimag[j] - x[2 * j + 1] * rreal[j];
            }

            //test the likelihood at this point
            double L = (ar * ar + ai * ai) / beta;
            if (L > Lopt) {
                Lopt = L;
                thetaopt = theta;
                dopt = sorted[0].value / 2.0;
            //System.arraycopy(x,0,xopt,0,2*T);
            }


            //run the search loop
            for (int m = 0; m < sortcount; m++) {

                int n = sorted[m].index;
                double s = Math.signum(d[n]);

                //update likelihood variables
                beta += 4 * s * x[n] + 4;
                ar += 2 * s * y1[n];
                ai -= 2 * s * y2[n];
                x[n] += 2 * s;

                //test the likelihood at this point
                L = (ar * ar + ai * ai) / beta;
                if (L > Lopt) {
                    Lopt = L;
                    thetaopt = theta;
                    if (m != sortcount - 1) {
                        dopt = (sorted[m].value + sorted[m + 1].value) / 2;
                    } else {
                        dopt = sorted[m].value + 1.0;
                    }
                //System.arraycopy(x,0,xopt,0,2*T);
                }

            }
        }


        double a = Math.cos(thetaopt);
        double b = Math.sin(thetaopt);
        for (int i = 0; i < 2 * T; i++) {
            d[i] = a * y1[i] + b * y2[i];
            xopt[i] = dopt * d[i];
        }
        NN(xopt, xopt);

        //Write the best codeword into real and
        //imaginary vectors
        toRealImag(xopt, dreal, dimag);

    }
    
    /** 
     * Run the noncoherent decoder with the current cyclic rotation 
     * of the pilot sequence.
     * @return The likelihood of this decoded sequence
     */
    private double decodeSequence(){
        return 0.0;
    }

    protected PilotSequence PATseq;
    
    public void setPilotSequence(PilotSequence ps) {
        PATseq = ps;
    }
}
