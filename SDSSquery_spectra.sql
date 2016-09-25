SELECT
  G.ra, G.dec, S.mjd, S.plate, S.fiberID,
  S.z, S.zErr, S.rChi2, S.velDisp, S.velDispErr,
  G.extinction_r, G.petroMag_r, G.psfMag_r, G.psfMagErr_r, 
  G.modelMag_u, modelMagErr_u, G.modelMag_g, modelMagErr_g,
  G.modelMag_r, modelMagErr_r, G.modelMag_i, modelMagErr_i, 
  G.modelMag_z, modelMagErr_z, G.petroR50_r, G.petroR90_r,
  --- line fluxes for BPT diagrams
  GSL.nii_6584_flux, GSL.nii_6584_flux_err, GSL.h_alpha_flux,
  GSL.h_alpha_flux_err, GSL.oiii_5007_flux, GSL.oiii_5007_flux_err, 
  GSL.h_beta_flux, GSL.h_beta_flux_err, GSL.h_delta_flux, 
  GSL.h_delta_flux_err, GSX.d4000, GSX.d4000_err, GSE.bptclass, 
  GSE.lgm_tot_p50, GSE.sfr_tot_p50, G.objID, GSI.specObjID
INTO mydb.SDSSspecgalsDR8 FROM SpecObj S CROSS APPLY
  dbo.fGetNearestObjEQ(s.ra, S.dec, 0.06) N, Galaxy G, GalSpecInfo GSI, 
  GalSpecLine GSL, GalSpecIndx GSX, GalSpecExtra GSE
WHERE N.objID = G.objID
  AND GSI.specObjID = S.specObjID
  AND GSI.specObjID = S.specObjID
  AND GSX.specObjID = S.specObjID
  AND GSE.specObjID = S.specObjID
  AND (G.petroMag_r > 10 AND G.petroMag_r < 18)
  AND (G.modelMag_u-G.modelMag_r) > 0
  AND (G.modelMag_u-G.modelMag_r) < 6
  AND (modelMag_u > 10 AND modelMag_u < 25)
  AND (modelMag_g > 10 AND modelMag_g < 25)
  AND (modelMag_r > 10 AND modelMag_r < 25)
  AND (modelMag_i > 10 AND modelMag_i < 25)
  AND (modelMag_z > 10 AND modelMag_z < 25)
  AND S.rChi2 < 2
  AND (S.zErr > 0 AND S.zErr < 0.01)
  AND S.z > 0.02
  
  


