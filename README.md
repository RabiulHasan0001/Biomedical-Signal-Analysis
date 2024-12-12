# Biomedical-Signal-Analysis


## Task 1 - Respiration Analysis

### Overview
Respiratory effort belts are widely used to monitor respiration noninvasively and continuously. They provide a convenient and comfortable method for observing respiratory patterns in sleep studies, detecting respiratory disorders, and monitoring respiration in children and infants. Respiratory belts eliminate the need for face masks or mouthpieces, which might otherwise alter breathing patterns.

Respiratory belts only provide qualitative data about chest and abdominal movements without calibration. After calibration, they enable the quantitative measurement of continuous respiratory volume and airflow.

The respiratory system can be modelled as a two-degree physical system in which the volume change of the chest and abdomen equals the volume measured at the mouth. Multiple linear regression is one method for calibrating these respiratory effort belts. 

In this assignment, I will:
- Study and test different prediction models.
- Evaluate their performance.
- Select the best model.

### Data
- **Chest and abdomen signals**: Measured using respiratory effort belts (arbitrary units, [au]).
- **Spirometer signal**: Measures airflow (ml/s).
- Sampling frequencies: 
  - 50 Hz for respiratory effort belt signals.
  - 100 Hz for spirometer signal.

> Note: The signals are heavily filtered for this assignment to ease implementation, but this is not acceptable in real scenarios as it distorts the signals.

### Useful MATLAB Commands
`load`, `resample`, `length`, `mean`, `sum`, `power`, `sqrt`, `corr`, `figure`, `subplot`, `plot`, `xlabel`, `ylabel`, `title`, `linspace`, `hold on`, `zeros`

### References
1. Konno K, Mead J (1967). Measurement of the separate changes of chest and abdomen during breathing. *J Appl Physiol*, 22:407-422.
2. Montgomery DC, Peck EA, Vining GG (2001). *Introduction to linear regression analysis.* 3rd ed. John Wiley & Sons.

---

## Task 2 - ECG Filtering to Remove Noise

### Overview
This assignment focuses on filtering ECG signals to remove noise while preserving signal integrity. I will:
- Remove high-frequency noise.
- Remove low-frequency noise (baseline wandering).
- Remove power-line interference.
- Analyze the impact of filtering in the time and frequency domains.

### Data
Filtered ECG signals and their sampling frequency are provided.

### Useful MATLAB Commands
`fft`, `filter`, `freqz`, `nextpow2`, `conj`, `ones`, `conv`, `semilogy`, `sgolayfilt`


---

## Task 3 - Adaptive Filtering

### Overview
This assignment introduces adaptive filtering techniques to separate fetal ECG signals from maternal ECG signals. I will:
- Use adaptive filters to cancel noise.
- Understand vector mathematics, cross-correlation, and interpolation.

### Data
- **Signals**: Mixed abdomen signals, pure fetal signals, and pure maternal signals.
- **Additional signals**: Respiratory reference and R-to-R intervals.

**Sampling rates**:
- `fhb`, `mhb`, `abd_sig1`, `abd_sig2`, `abd_sig3`: 1000 Hz
- `RespReference`, `RRiInput`: 4 Hz



---

## Task 4 - Pan-Tompkins Algorithm for QRS Detection

### Overview
The Pan-Tompkins algorithm is used to detect QRS complexes in ECG signals. This assignment involves:
- Noise reduction.
- Signal differentiation and squaring.
- Moving-window integration.
- Detection of QRS complexes.

### Data
The input ECG signal is provided in `ECG.txt` with a sampling rate of 200 Hz.

### Useful MATLAB Commands
`filter`, `ones`



---

## Task 5 - EMG and Muscular Force Analysis

### Overview
In this assignment, I will analyze EMG signals to investigate their relationship with muscle force. I will:
- Compute dynamic range (DR), mean squared (MS) value, zero-crossing rate (ZCR), and turns count rate (TCR).
- Evaluate the goodness of fit of linear models.

### Data
- **Signals**: EMG data with mean subtracted.
- **Sampling rate**: 2000 Hz.
- Data provided in `data.mat`.

## Task 6 - Bayesian Inference and Parameter Estimation

### Overview
This assignment focuses on Bayesian inference and parameter estimation. I will:
- Understand key Bayesian concepts such as prior, likelihood, posterior, and Bayes' rule.
- Apply probabilistic models to estimate parameters.
- Implement outlier-robust methods.
- Use Gaussian mixture models for clustering problems.

### Tasks
1. Explore parameter estimation in linear regression without outliers.
2. Analyze methods to handle outliers effectively.
3. Apply Gaussian mixture models for clustering in a multi-modal dataset.

### Learning Goals
- Understand Bayesian inference.
- Apply traditional and Bayesian methods for parameter estimation.
- Implement outlier-robust methods.

### Data
The provided dataset contains observations and parameters for regression and clustering tasks.

### Useful MATLAB Commands
`normpdf`, `mvnpdf`, `inv`, `chol`, `mean`, `std`, `plot`, `scatter`, `linspace`



---



