-- Create indexes for optimizing queries

-- Index on SUBPOP.CONTRACT_TARGETS
CREATE INDEX idx_contract_targets
ON SUBPOP.CONTRACT_TARGETS (product_id, measure_abbr, submeasure_name, submeasure_stratification);

-- Index on FINAL_RATES.SUMMARY
CREATE INDEX idx_final_rates_summary
ON FINAL_RATES.SUMMARY (product_id, measure_abbr, submeasure_name, submeasure_stratification);
