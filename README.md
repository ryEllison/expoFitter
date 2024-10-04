
<img src=".\static\hex.png" width="25%" height="25%" style="display: block; margin: auto;" />

# Overview

**expoFitter** is a specialized tool for visualizing and fitting
non-linear electrophysiological data, built using *R Shiny* and
*flexdashboard*. Designed to model slow neuronal currents like the
calcium-dependent potassium current ($I_{KCa}$), **expoFitter** provides
robust methodologies for fitting and analyzing current kinetics through
single- and double-exponential models. This allows researchers to
extract time constants and assess model fitness, giving insight into
current dynamics. While expoFitter does not directly measure
intracellular calcium ($[Ca^{2+}]_i$) dynamics, the tool’s modeling
logic and uncovered temporal information has been effectively used as an
indirect measure of $[Ca^{2+}]_i$ changes in neurons of the lobster
pyloric network, as demonstrated in ongoing research (Ellison et al.,
*in progress*; Thuma et al., *in progress*). The tool’s robust
non-linear least squares optimization makes it highly effective for
studying slow electrophysiological processes.

# Tool Features

- **Data Preprocessing and Filtering**: Incorporates a unique data
  wrangling/filtering algorithm that utilizes both finite and simple
  differentiation to extract salient parts of the current trace,
  ensuring accurate and reliable model fits. This preprocessing step is
  essential for isolating active portions of the current.

- **Native Model Parameter Approximator**: Integrates approximator
  functionality automating model initial-conditional estimates based on
  quintessential features of the experimental data. Given the robustness
  of the optimizer, this reduces the need for manual adjustment of these
  parameters by the user.

- **Flexible and Robust Exponential Model Fitting**: Supports both
  single- and double-exponential model fits using the `nlsLM` algorithm
  from the `minpack.lm` package. The `nlsLM` algorithm implements the
  *Levenberg-Marquardt Algorithm*, which combines gradient descent and
  the Gauss-Newton method for robust non-linear least squares
  optimization (see Supplemental Information below). The application
  fits experimental data using the following exponential models:

  - **Single-Exponential Model**:

  $$I = A e^{-\frac{t}{B}} + C$$

  - **Double-Exponential Model**:

  $$I = A e^{-\frac{t}{B}} + C e^{-\frac{t}{D}} + E$$ where $B$ and $D$
  represent the time constants of the first and second phase of the
  exponential curve, respectively.

- **Interactive Visualization and Model Parameter Adjustment**: Provides
  a fully interactive interface for data visualization and model
  fitting, enabling users to dynamically adjust model parameters through
  sliders and observe the resultant model solution both quantitatively
  and visually.

# Installation

### **expoFitter** Locally

There are several ways to access **expoFitter**. If you want the
entirety of the repository, you can clone it to your local machine using
these *terminal* commands (*terminal* used generically throughout):

``` bash
git clone https://github.com/ryEllison/expoFitter.git
cd expoFitter
```

Ensure you are in the desired directory before executing the terminal
commands. You can also use a point-and-click approach by navigating to
*Code* in Github and selecting *Download ZIP*. Downloading
**expoFitter** this way will require your moving expoFitter from your
local Downloads to the desired location on your machine.

To run **expoFitter** locally, ensure that `R` is installed on your
system, as well as the following packages:

- `dplyr 1.1.4`
- `minpack.lm 1.2.4`
- `DT 0.33`
- `shiny 1.9.1`

and your system’s environmental variables provide terminal access to
`R`’s interpreter `Rscript`. Package installation is automated and can
be completed by running the `install_dependencies` pseudo-executable in
the `\bin` directory.

**expoFitter** can then be deployed utilizing your machine as a local
server via the `expoFitter_R` pseudo-executable in the `\bin` directory.
To make any tweaks or alterations to the tool to fit your particular use
case, the code is dispersed throughout appropriate directories (e.g.,
`\app`, `\scripts`, and `\src`).

### **expoFitter** as Electron App

**expoFitter** has also been built as a portable, desktop `Electron`
app. The `Electron` build can be found in the `\electron` directory.
However, for access to the desktop app the `\installer` directory can be
downloaded using this terminal approach:

``` bash
git clone https://github.com/ryEllison/expoFitter/installer.git
cd expoFitter
pseudo_installer
```

### **expoFitter** on Shinyapp.io

<!-- # Usage -->
<!-- ### Data Input -->
<!-- - Upload a `.csv` file containing time and current data. Ensure that the file has at least two columns: -->
<!--     - Column 1: Time (in seconds) -->
<!--     - Column 2: Current (in nanoamps) -->
<!-- ### Model Initialization -->
<!-- - **Select Model**: Choose between a 'Single-Exponential,' 'Double-Exponential,' or 'Both' models from the dropdown menu. -->
<!-- - **Adjust Parameters**: Use the sliders to set initial values for model parameters (`A`, `B`, `C`, `D`, etc.). -->
<!-- ### Visualization and Fitting -->
<!-- - **Visualize Data**: The app plots the input current vs. time data automatically. -->
<!-- - **Fit Model**: Click the 'Fit Model' button to apply the selected model to the data and visualize the fitted curve. -->
<!-- ### Saving Results -->
<!-- - Once the model fitting is complete, you can save the resulting plot as a `.pdf` file by clicking the 'Save' button in the interface. -->
<!-- ### Output -->
<!-- - Model parameters, R² values, and fitting summaries are displayed in the 'Model Solution' section, providing quantitative feedback on the model's performance. -->
<!-- # Contact Information -->
<!-- For further questions or collaborations, feel free to contact the project developer: -->
<!-- **Ryan Ellison, PhD**   -->
<!-- Neuroscientist   -->
<!-- [ryan.dean.ellison@gmail.com](mailto:ryan.dean.ellison@gmail.com)   -->
<!-- Graduate, Ohio University (Neuroscience; Computational Neuroscience, AI/ML) -->
<!-- # Acknowledgments -->
<!-- This application is inspired by Dr. Ellison's research in computational neuroscience, focusing on the analysis of electrophysiological processes in motor control and neural activity. The design leverages Dr. Ellison's expertise in both the computational and experimental realms of neuroscience. -->
<!-- ### Contact Information -->
<!-- For further questions or collaboration, please contact: -->
<!-- **Ryan Ellison, PhD**   -->
<!-- [Email](mailto:ryan.dean.ellison@gmail.com) | [GitHub](https://github.com/ryEllison) -->
<!-- # Additional Resources -->
<!-- For more details on the scientific basis and applications of the expoFitter tool, please refer to Dr. Ellison's publications and research in computational neuroscience and electrophysiological data analysis. -->

# Supplemental Information

## **Levenberg-Marquardt Algorithm**

Update rule:

$$\mathbf{x}_{k+1} = \mathbf{x}_k - \left( \mathbf{J}^T \mathbf{J} + \lambda \mathbf{I} \right)^{-1} \mathbf{J}^T \mathbf{r}$$

Where:

- $\mathbf{J}$ is the Jacobian matrix of the residuals,
- $\mathbf{r}$ is the residual vector (differences between observed and
  predicted data),
- $\lambda$ is a damping factor that controls the transition between
  gradient descent (for stability) and the Gauss-Newton method (for
  faster convergence).

### **Gradient Descent** (when $\lambda$ is large)

Update rule:

$$\mathbf{x}_{k+1} = \mathbf{x}_k - \alpha \nabla F(\mathbf{x}_k)$$

Where:

- $\alpha$ is the learning rate,
- $\nabla F$ is the gradient of the cost function.

### **Gauss-Newton Method** (when $\lambda$ is small)

Update rule:

$$\mathbf{x}_{k+1} = \mathbf{x}_k - \left( \mathbf{J}^T \mathbf{J} \right)^{-1} \mathbf{J}^T \mathbf{r}$$

These methods ensure high-fidelity parameter estimation for complex
neuroelectrophysiological datasets.
