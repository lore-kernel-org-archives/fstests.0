Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03FE27703E
	for <fstests@vger.kernel.org>; Fri, 21 Nov 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742039; cv=none; b=TedOgzy7g1j8URXNoQREd/2OLSaVs1v+Y9gnUFRY49o9TyrR+VoC+sUUlly3VrCLw8D28MpzIdpw6QweMtyV8l99NcvYDAIGikgkKAqudPrhxbVtf95cs50vLmx+14x0n2WfZmc9gD53u85cK2OjRneryevoXw2LchGSgD+EUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742039; c=relaxed/simple;
	bh=cpz9t1UGGZr/PXb6IC3wehJha9F0RaSXPQCecKsza24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyMRjIkWfQmVE2fcl8yMyZeedP06SFHmK73P2l25v+rAX7dXd5pgys6JJp88d77fkmpj1U0aJzgtdMQ6OebHW/L/G3HSzkswnUx3N/Jdb0dQ/caoSsYy+2Ta90D4scDlrIe4aGUmkXSgmtQ5Vj3asZcusmuKUohx83Iz5zuCnNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5CdFI6e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5CdFI6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C77C4CEF1;
	Fri, 21 Nov 2025 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742038;
	bh=cpz9t1UGGZr/PXb6IC3wehJha9F0RaSXPQCecKsza24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5CdFI6eNNFpa41cbseip7S8bxPLOWp2Hdiosg7bhwqbuR/cjvcoXXx476pmfFj7f
	 FRPjJ0AA7ZvyTiGkKuxyFjBj/vnAK2FRjHkGGSEI8jAvmb6yim5P1mM0DlVD/Obdf1
	 5FIid7G4uIzjTHejP6YAUYOLmYgVoH/gVDqWVAC5w7vCj8ltfduHbIOwELTXfCQDrW
	 WgE27UGAaH9UlD+RuZEb9etOVbsZrCrN0o5QnwzTSPrt2Is4SsoTwX27I1KaM7Ib8d
	 KdgrD1vquPUzsAwK34M8Ftlw6kyCzrTOnNMye7KE1Uw1tOVA0jbU3OO3RRS32Kv17Q
	 d+lL1Y0Piec8g==
Date: Fri, 21 Nov 2025 08:20:37 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: fix _xfs_is_realtime_file for internal rt
 devices
Message-ID: <20251121162037.GG196391@frogsfrogsfrogs>
References: <20251120160901.63810-1-cem@kernel.org>
 <20251120231536.GK196366@frogsfrogsfrogs>
 <aSAK8qG0vFjK79z4@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSAK8qG0vFjK79z4@infradead.org>

On Thu, Nov 20, 2025 at 10:47:14PM -0800, Christoph Hellwig wrote:
> On Thu, Nov 20, 2025 at 03:15:36PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Now that we can have internal realtime devices, it's possible to have a
> > realtime filesystem without setting USE_EXTERNAL=yes or SCRATCH_RTDEV.
> > Use the existing _xfs_has_feature helper to figure out if the given path
> > points to a filesystem with an online realtime volume.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> although right now it should not matter - one user of
> _xfs_is_realtime_file requires reflinks and the other explicitly
> excludes zoned file systems.

I know; I found this by observing that one of the new xfs_healer tests
wasn't working quite right on internal-zoned xfs.  There wouldn't be
much point in citing xfs/1899 as the discovery point. :(

--D
