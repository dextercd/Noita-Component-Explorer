local beta_version = {}

-- Table just indicates compatibility with certain betas.
-- Used to gate certain features/options that only work on later versions of Noita.

beta_version.dec31_beta = ModDoesFileExist and ModDoesFileExist("data/entities/items/pickup/give_all_perks.xml")

return beta_version
