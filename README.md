
<img src=".\rmd\static\hex.png" width="25%" height="25%" style="display: block; margin: auto;" />

# Overview

**expoFitter** is a specialized tool for visualizing and fitting
non-linear electrophysiological data, built using R, Shiny, and
Flexdashboard. The tool provides robust methodologies for fitting
dynamic processes through single- and double-exponential models,
allowing researchers to extract time constants and assess model fitness.
Its robust non-linear least squares optimization makes **expoFitter**
efficient for fitting complex data.

In scientific applications, **expoFitter**, or its backend logic, has
been used to analyze slow neuronal currents like the calcium-dependent
potassium current ($I_{KCa}$; Ellison et al., in progress; Thuma et al.,
in progress). While it does not directly measure intracellular calcium
($[Ca^{2+}]_i$) dynamics, the tool’s modeling logic and resulting
uncovered temporal information have been used to indirectly measure
$[Ca^{2+}]_i$ time-dependent changes in neurons of the lobster pyloric
network, as demonstrated in ongoing research (Ellison et al., in
progress; Thuma et al., in progress).

# Tool Features

- **Data Preprocessing and Filtering**: Incorporates a unique data
  wrangling/filtering algorithm that utilizes both finite and simple
  differentiation to extract salient parts of the current trace,
  ensuring accurate and reliable model fits. This preprocessing step is
  essential for isolating active portions of the current.

- **Native Model Parameter Approximator**: Integrates approximator
  functionality automating model initial condition estimates based on
  quintessential features of the experimental data. Given the robustness
  of the optimizer, this reduces the need for manual adjustment of these
  parameters by the user.

- **Flexible and Robust Exponential Model Fitting**: Supports both
  single- and double-exponential model fits using the `nlsLM` algorithm
  from the `minpack.lm` package. The `nlsLM` algorithm implements the
  *Levenberg-Marquardt Algorithm*, which combines gradient descent and
  the Gauss-Newton method for robust non-linear least squares
  optimization (see Supplemental Information). The application fits
  experimental data using the following exponential models:

  - **Single-Exponential Model**:

  $$I = A e^{-\frac{t}{B}} + C$$

  - **Double-Exponential Model**:

  $$I = A e^{-\frac{t}{B}} + C e^{-\frac{t}{D}} + E$$

  where $B$ and $D$ represent the time constants of the first and second
  phase of the exponential curve, respectively.

- **Interactive Visualization and Model Parameter Adjustment**: Provides
  an interactive interface for data visualization and model fitting,
  enabling users to dynamically adjust model parameters through sliders
  and observe the resultant model solution both quantitatively and
  visually.

# Installation

### **expoFitter** Locally

There are several ways to access **expoFitter**. If you want the
entirety of the repository, you can clone it to your local machine using
these terminal commands (*terminal* used generically throughout):

``` bash
git clone https://github.com/ryEllison/expoFitter.git
cd expoFitter
```

Ensure you are in the desired directory before executing the terminal
commands. You can also use a point-and-click approach by navigating to
*Code* in Github (Figure 1) and selecting *Download ZIP* (Figure 2).
Downloading **expoFitter** this way will require your moving
**expoFitter** from your local downloads to the desired location on your
machine before decompressing the file.

<div class="figure" style="text-align: center">

<img src=".\rmd\static\code.png" alt="Figure 1. Navigate to Code in Github."  />
<p class="caption">
Figure 1. Navigate to Code in Github.
</p>

</div>

<br>

<div class="figure" style="text-align: center">

<img src=".\rmd\static\downloadZIP.png" alt="Figure 2. Select Download ZIP."  />
<p class="caption">
Figure 2. Select Download ZIP.
</p>

</div>

<br>

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
git clone --no-checkout https://github.com/ryEllison/expoFitter.git
cd expoFitter
git sparse-checkout init --cone
git sparse-checkout set ./installer
git checkout master
cd installer
pseudo_installer.bat
```

Again, ensuring you are in the directory where you wish the installer to
be placed before executing the terminal commands.

You can also use a point-and-click approach to directly download the
installer by navigating to `installer.zip`, clicking the *ellipsis* in
the upper right corner (Figure 3), and selecting *Download* (Figure 4;
or, using the respective keyboard shortcuts once `installer.zip` has
been accessed, e.g., `CTRL + SHIFT + S`). Downloading **expoFitter**
this way will require your moving the installer from your local
downloads to the desired location on your machine before decompressing
the file and executing the `pseudo-installer` pseudo-executable.

<div class="figure" style="text-align: center">

<img src=".\rmd\static\ellipsis.png" alt="Figure 3. Location of ellipsis option in upper right corner."  />
<p class="caption">
Figure 3. Location of ellipsis option in upper right corner.
</p>

</div>

<br>

<div class="figure" style="text-align: center">

<img src=".\rmd\static\download.png" alt="Figure 4. Select Download from ellipsis dropdown."  />
<p class="caption">
Figure 4. Select Download from ellipsis dropdown.
</p>

</div>

### **expoFitter** on shinyapps.io

Lastly, **expoFitter** has been made publicly available as a web app,
which is hosted on [shinyapps.io](https://www.shinyapps.io/) and can be
accessed using <https://ryellison.shinyapps.io/expofitter/>.

# Usage

### Data Input

- Upload a `.csv` file using `Browse...` under `Select File` containing
  electrophysiological (e.g., neuronal current) time-series data. Ensure
  the dataset has *at least* two columns, e.g.,

<div class="figure" style="text-align: center">

<img src=".\rmd\static\dataset.png" alt="t is time in seconds (s) and i is current data in nanoamps (nA)."  />
<p class="caption">
t is time in seconds (s) and i is current data in nanoamps (nA).
</p>

</div>

- The backend logic of **expoFitter** relies on positional encoding of
  the data (i.e., utilizes data structure indices for lazy data
  handling). This, however, makes **expoFitter** more robust in data
  preparation as column name is inconsequential. All of this is to say,
  ensure that the dataset is ordered column-wise where the first column
  contains time data and the second column contains the dynamic process
  data. If there are more than two columns, column order after the
  second column is trivial.

### Model Selection and Initialization

- The `Select Model` dropdown menu under `Model Initialization` allows
  the user to choose between a ‘Single-Exponential,’
  ‘Double-Exponential,’ or the implementation of ‘Both’ models.

- The native model parameter approximator auto-estimates initial
  conditions based on the data and selected model. The sliders can be
  used to adjust model parameter (`A`, `B`, `C`, `D`, etc.) initial
  values if the auto-estimated parameters fail.

- The `Fit Model` button must be clicked to run model.

### Visualization, Fitting, and Performance Reporting

- **expoFitter** automatically visualizes the time-series data it
  ingests.

- Once `Fit Model` is clicked as described above, **expoFitter** will
  utilize the model parameters auto-estimated or manually selected
  through alteration of the sliders and then fit the model to the
  dynamic process using non-linear least squares optimization (see
  Supplemental Information).

- When the model(s) error minimization is complete, the model fit is
  visualized in the figure.

- The performance report is provided in the `Model Solution` section,
  showing the best fit model’s parameters and a quantitative summary of
  model fitness.

### Saving Results

- When data is uploaded to **expoFitter** the save functionality
  dynamically appears.

- The user can save the base plot of the electrophysiological data by
  selecting `Save` before fitting a model.

- Once a model is fit to the data, the figure observed in the
  `Visualization` section can be saved by clicking the `Save` button in
  the interface.

All visualizations are saved as a `.pdf` file.

# Related Works

**Ellison, R.**, Thuma, J.B., Hooper, S.L. (in progress). $I_{KCa}$
trajectory reveals extremely slow (seconds-long) $[Ca]_{i}$ removal
dynamics in a lobster pyloric neuron.

Thuma, J.B., **Ellison, R.**, Hooper, S.L. (in progress). What slow
$I_{KCa}$ reveals about $[Ca]_{i}$ removal dynamics in the lobsyer
pyloric network.

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
