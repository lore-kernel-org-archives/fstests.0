Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AFB481D1
	for <fstests@vger.kernel.org>; Mon,  1 Apr 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990607; cv=none; b=aA5DbZb4+Fd7OEhCvWm88Bq9+YAOI0b8DQmAj4Gt6O6DLchWWOzGQlFEXm7EYOZHBWnZT0tVXRmwtKfhtCClu3iAc+Kd6b7tLPVL1pAdBZPvE23WU4SYRtdwofA4r8uP242T8aiu03WXFumYOdP5PanQbblcKS/G2qUTy8hHvaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990607; c=relaxed/simple;
	bh=KTk2nCoSXUN+1PHwig9llu+Iv0hvMQO2Mk3LcqM24P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flJV9+M9iUdxhRUpmYvQFPvKSGTPsJlx7ZkYs/VKYgJS9F9Lo2HZ8Vymq3MdtB3epgbgLZIIW3lW4HoLchDRAbRLtX3f70pGFYeY0W2T8uSiP/VgEJCoz+cF5wcnv3DX0H4JuD1cEGGucedTblAIr2bV8arUPeOt4SlHsNq7Ph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XdPWtyhq; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XdPWtyhq"
Received: from cwcc.thunk.org (pool-173-48-113-232.bstnma.fios.verizon.net [173.48.113.232])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 431GuDVS014708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 12:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1711990575; bh=DGDWIPhbXO5gyTI7L9SBAFsHMJAybqTBJB97J3SSDYU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=XdPWtyhqTKz3MdpXcQJo5Z3XpV1JJUEP/eQCaI6OqpnzU8ZET4pQFwNVawGKF9iNF
	 wiBVHb7MJwKFnr8daQquv8TiFwDrmn563ZIkC4H8bNYOT5hEES72u7cvVzJt7D9FFM
	 sGhlen8mNzlHqPAuZsYdFosMc8FyjMLEFRcPMwOXDMQtS3Pmu6slZOdj/iasNwVfV/
	 5bjb/tJ0BSMnOOz1Ld88W7PasueXkEDDaYbq3AxrY3f6VppR9uSngKUnVPewp7S37e
	 +PK/y9R8TLsyQ0ceLtjgI/L1HM3ToTZK1sNs852TsxiJYL43Owl3a6zHlP0B5PN3aB
	 MeVKJnK9SW1Tw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4F5BB15C00DC; Mon,  1 Apr 2024 12:56:13 -0400 (EDT)
Date: Mon, 1 Apr 2024 12:56:13 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH v2] ext4/01{2,9}: fix invalid filesystem option 'journal'
Message-ID: <20240401165613.GA2046915@mit.edu>
References: <20240401095709.12304-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401095709.12304-1-luis.henriques@linux.dev>

On Mon, Apr 01, 2024 at 10:57:08AM +0100, Luis Henriques (SUSE) wrote:
> Creating an ext4 filesystem using '-O journal' will fail with:
> 
>     Invalid filesystem option set: journal
> 
> Fix it by replacing it by '-O has_journal', which ensures the filesystem
> (ext3 or ext4) is created with a journal.  While there, also redirect stderr
> and stdout to the full log.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
