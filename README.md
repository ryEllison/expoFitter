
<img src=".\static\hex.png" width="25%" height="25%" style="display: block; margin: auto;" />

# Overview

**expoFitter** is a Shiny-based application designed for the analysis
and modeling of electrophysiological data, with a focus on current
vs. time traces commonly encountered in neuroscience research. The app
provides tools for data visualization, preprocessing, and fitting of
both single- and double-exponential models. This facilitates the study
of dynamic processes in neuronal systems, such as ionic currents,
calcium dynamics, or neural network behavior.

The application includes backend functions for filtering data, computing
coefficients of determination (R²), and fitting models using non-linear
least squares optimization. Additionally, the app provides an intuitive,
interactive interface for setting model parameters and visualizing
fitted models.

# Features

- **Data Filtering**: Employs finite differences and simple differences
  to filter noise from experimental data.
- **Exponential Model Fitting**: Supports single- and double-exponential
  model fitting using the `nlsLM` algorithm.
- **Interactive Visualization**: Visualizes raw data and fitted models
  with dynamic slider inputs to adjust fitting parameters.
- **Flexible UI**: User-friendly interface powered by R Shiny and
  `flexdashboard` for flexible, customizable data exploration.

# Installation

To run the `expoFitter` application locally, ensure that R is installed
on your system along with the following packages:

- `dplyr`
- `minpack.lm`
- `DT`
- `shiny`

### Step-by-Step Instructions

1.  Clone this repository to your local machine:
    `bash     git clone https://github.com/your-username/expoFitter.git`

2.  Navigate to the repository directory: `bash     cd expoFitter`

3.  Open R or RStudio and install the required packages:
    `r     install.packages(c('dplyr', 'minpack.lm', 'DT', 'shiny'))`

4.  Run the application: `r     shiny::runApp('path/to/repository')`

Alternatively, you can deploy the app directly from RStudio using the
`Run App` button.

# Usage

### Data Input

- Upload a `.csv` file containing time and current data. Ensure that the
  file has at least two columns:
  - Column 1: Time (in seconds)
  - Column 2: Current (in nanoamps)

### Model Initialization

- **Select Model**: Choose between a ‘Single-Exponential,’
  ‘Double-Exponential,’ or ‘Both’ models from the dropdown menu.
- **Adjust Parameters**: Use the sliders to set initial values for model
  parameters (`A`, `B`, `C`, etc.).

### Visualization and Fitting

- **Visualize Data**: The app plots the input current vs. time data
  automatically.
- **Fit Model**: Click the ‘Fit Model’ button to apply the selected
  model to the data and visualize the fitted curve.

### Saving Results

- Once the model fitting is complete, you can save the resulting plot as
  a `.pdf` file by clicking the ‘Save’ button in the interface.

### Output

- Model parameters, R² values, and fitting summaries are displayed in
  the ‘Model Solution’ section, providing quantitative feedback on the
  model’s performance.

# Contribution Guidelines

If you would like to contribute to `expoFitter`, please adhere to the
following guidelines:

1.  **Fork the Repository**: Start by forking this repository to your
    own GitHub account.

2.  **Clone Your Fork**: Clone the forked repository to your local
    development environment.
    `bash     git clone https://github.com/your-username/expoFitter.git`

3.  **Create a New Branch**: Make your changes in a new branch.
    `bash     git checkout -b feature-name`

4.  **Testing**: Ensure that all new features are fully tested. Utilize
    mock datasets for validation of model fitting functionalities.

5.  **Submit a Pull Request**: Once your changes are ready, submit a
    pull request with a clear description of your additions or
    modifications.

### Code Style

- Follow the R language style guide: [Google’s R Style
  Guide](https://google.github.io/styleguide/Rguide.html).
- Write clear and concise comments for each function, describing input
  parameters and return values.

# License

This project is licensed under the MIT License - see the
[LICENSE](LICENSE) file for details.

# Acknowledgments

This application is inspired by Dr. Ellison’s research in computational
neuroscience, focusing on the analysis of electrophysiological processes
in motor control and neural activity. The design leverages Dr. Ellison’s
expertise in both the computational and experimental realms of
neuroscience.

### Contact Information

For further questions or collaboration, please contact:

**Ryan Ellison, PhD**  
[Email](mailto:ryan.dean.ellison@gmail.com) \|
[GitHub](https://github.com/ryEllison)

# Additional Resources

For more details on the scientific basis and applications of the
expoFitter tool, please refer to Dr. Ellison’s publications and research
in computational neuroscience and electrophysiological data analysis.
