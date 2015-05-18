function res = normalizeFeature(feature)
    total = sum(feature);
    res = feature / total;
end