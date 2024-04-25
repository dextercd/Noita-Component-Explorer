local beta_version = {}

-- Table just indicates compatibility with certain betas.
-- Used to gate certain features/options that only work on later versions of Noita.

beta_version.is_beta = not not CellFactory_HasTag

return beta_version
