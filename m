Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202811;
	b=tJrGYsQwQfevZKQJb0NkZqVjJVTPdKFJbMWP6UFdJW+oHAp84yuobkrbiX1cbFm53zPv
	 mi+lyZWw5nlnzqTVGPJhuC9keaRz5+qwRewizVkVHFkAZf1Fj6NVcsXDhqT80+yn5d4Ak
	 ph1Cjp0XXDDHqokI3k7PoXozaQFTSO89ekJwFFfgQBmboQ0cpdibirMTwnIRYw9YnTNvi
	 LttMLoU0AlAdK0UJbjudx9qs3ZxNcC0rhPb5v36xs37m0uIqarSU3/m4zg5rtakfRXfUd
	 jguenb/fH2tzHR6NrzwHdlpnSXbGIQBtYjhI9I30vFME7fD/Lase5I/4xn7VwZpY6sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202811;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=8N9Vex6utStwOHVgBphL4RZO9H9DTrnPT8rftI4Ug5w=;
	b=XDjzf8RqENOPLPixNdfrDxtKwX5zlMmslqGgBaYIMoPy/L3qp8Ck95Q/hfE/hegSlPYp
	 FS7EzBt0acOeMB/412F3pF2zQFEH0gWcRDG7udc0jEBaO4xnywtPwtpP7rCkBOyCwRmpH
	 GfMGRPp7Ax155KSkQbyu1nKNASP84BYs+RCz9R3Grmr0YtY7q2ru1+axGJEdw673ob3EU
	 AVUPuDc3iV3t7KMFQU4ksq7EpzhB3syZF1i4ZBOvZ1MyZSsufkWDojT2rV6VkZ/jIjELY
	 m5zRo9ooKntNTtc/XJAeViwi9QTfNRgo4grGKkcUCAXBrWHX+7PmP1fcu0T5wFh3vRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wH1lwNYc;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66C606A31D
	for <fstests@vger.kernel.org>; Wed, 28 Oct 2026 15:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF66C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wH1lwNYc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8N9Vex6utStwOHVgBphL4RZO9H9DTrnPT8rftI4Ug5w=; b=wH1lwNYcAETv17nY5/uMW568c4
	dAjCTgov35KNdDtlPiPVdwFs/CT2EEr84gFer3tDb4Void9Nk4R6nzClPA/nwa8GWOZzqHfBVnP57
	FmEUvUDbhBHpwTyyEBxESxveC5m8AbpLVSXqZtXe9uaPEMS4FjDHWbsCBVb1+C0Ou2pl9LegLtNzJ
	4PORzkOS6gZBvbhuqzKtBQDfXg804bu8i/mI84UpfoCNMsmcN2WmDjOuktsoWp1U/3V7HXtjvHa5s
	HdPo/udYfCSgurAFnHqiP8Urh/U92uPLWzXbF8VsknGBPqr0U3YxSNMn77i5xp9+SRzCvxWfXZLiT
	w9s9/nXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5xy-00000007T9r-1BE4;
	Wed, 28 Oct 2026 15:53:30 +0000
Date: Wed, 28 Oct 2026 08:53:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: lan@suse.com
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/095: ignore EBUSY for job5 on NFS
Message-ID: <auIaelRXtRVuOzDD@infradead.org>
References: <20261012025707.16720-1-lan@suse.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012025707.16720-1-lan@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 12, 2026 at 10:57:07AM +0800, lan@suse.com wrote:
> From: An Long <lan@suse.com>
> 
> On NFS, the buffered read in job5 occasionally fails with EBUSY:
> 
>   fio: io_u error on file <dir>/file2: Device or resource busy: read ...
> 
> This most likely happens because the client has to invalidate its page
> cache before reading a file that other jobs may have modified, and that
> cannot complete while those jobs keep mixing direct, buffered and mmap
> writes on the same files.
> 
> Make this error ignorable for job5 reads only, and only when testing
> NFS, so that unexpected errors from other jobs or other filesystems are
> still reported. Since ignore_error given on the fio command line applies
> to all jobs, move it into the job file, where it can be overridden per
> job. Behaviour for other filesystems and jobs is unchanged.

File system specific hacks in common code are usually not a good idea.
And I think in this case nfs is broken - just like other file systems
it should fall back to buffered I/O when the invalidation fails.

