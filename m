Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3E3563EB
	for <fstests@vger.kernel.org>; Sun, 19 Jul 2026 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784453096; cv=none; b=KWd2bVioyO51Yaihbf2Ms26IY5J+5IQmHwxBV3msveCqqyfsHwFTVvRPFKhfHYZiOLP0PnuzWq6vD3syO0dGqhQnAy7MjMM7UQ9R5fjKT9sMIhCFnZWXWYVr6mZIXw+ySiTqwszby3KTb8XPcTTId13wGBP340Tey+lqkaEjFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784453096; c=relaxed/simple;
	bh=DCa1FLbyZR7oAhtU95iGLowMZzs2UhTe9+JO054TGSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8yQPwvcmCEfaRIBOEWj1m2lG72+XkPWLp7Neyxoy6ct9W+ncT1tSoM3mHqk4YRrc0mC5aLw27RaHW9j6d4mxWWHqumgBidbINAB0KC4BDCBl9633tPM980OWpCqVT29vOyQX+zDGKcuzK6EqfL4+2fFQEn0xQrEUqQ49VGMEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K99RGjD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K99RGjD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1926E1F000E9;
	Sun, 19 Jul 2026 09:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784453095;
	bh=hlcFkYOTVjgj40EJYE2FLarQkNMyiNL2f8HWPLYDJMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K99RGjD/nSQfF9NCIJd3xX3vHo7jXLmrcabEIWyknnuTAFkjysjXG7d83Qeiwpw31
	 iENrDt5uFoDhlRzBcw3iKhTHIU377vTFt+5YoKpUidvvwUXBiif9IKxZEtzHunxd69
	 HZtmrP2xLFM0dNkXxlDkrWCGEIsbawGMObD836YUqskCMEP/PLtaaA7eqdTZeNFJcn
	 QL7Xtr2PomXpCHoe06E2+znYWHXhwa3TrCULJ4iafgwBQ1qljgfESdnzmsJ5U9YQWK
	 CGuLUE/Qadyq5dR5StVMgftyzgOs30BmNlxMG35wGDWlZoMuktVelANaIPWQzOFkJc
	 GslivruuomQbA==
Date: Sun, 19 Jul 2026 17:24:45 +0800
From: Zorro Lang <zlang@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Jan Prusakowski <jprusakowski@google.com>, linux-f2fs-devel@lists.sourceforge.net, fstests@vger.kernel.org, 
	jaegeuk@kernel.org
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
Message-ID: <alyS3PRtALHIV5no@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Jan Prusakowski <jprusakowski@google.com>, 
	linux-f2fs-devel@lists.sourceforge.net, fstests@vger.kernel.org, jaegeuk@kernel.org
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org>
 <akKd2IImO7bRjVV2@zlang-mailbox>
 <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>

On Tue, Jun 30, 2026 at 08:09:19PM +0800, Chao Yu wrote:
> On 6/30/26 00:37, Zorro Lang via Linux-f2fs-devel wrote:
> > On Wed, Jun 24, 2026 at 12:46:01AM -0700, Christoph Hellwig wrote:
> >> This sounds odd.  The test allocates a contigous range and then just does
> >> insert/collapse on it, which should not lead to any new data block
> >> allocations.  Given that the test works fine on zoned XFS and btrfs
> >> with strict out of place write policies we know it does not require
> >> overwriting blocks to work as well.
> >>
> >> So I think something is fishy in f2fs if needs to allocate data blocks
> >> here.
> > 
> > I have the same question with Christoph. Shouldn't fcollapse in F2FS just
> > remap the metadata instead of allocating new data blocks?
> 
> Hi Christoph, Zorro,
> 
> Let me explain it briefly, this is because f2fs has only one copy of reverse
> mapping table (aka SSA), for any checkpointed data, we can not modify SSA info
> directly during remap, otherwise, after sudden power-cut, we will suffer
> inconsistent issue in between reverse mapping table and mapping table. So, f2fs
> choose to rewrite for any checkpointed data.

Hi Chao,

Thank you for the detailed explanation. I now see why F2FS handles this
differently.

Since this is by design for F2FS, I'd like to merge this fix to help f2fs
avoid this test failure at first. As for the potential write amplification
and performance overhead introduced by this rewrite strategy, that can be
discussed further on the f2fs list if necessary.

I will merge the patch with some clarifying comments:

/*
 * F2FS uses a rewrite strategy for fcollapse/finsert on checkpointed data.
 * Since F2FS has only a single copy of the reverse mapping table (SSA),
 * directly remapping checkpointed metadata could cause inconsistency
 * issues after a sudden power-cut.
 */

Is this ^^ good to you, or feel free to give me a proper comment to add into
this patch.

Thanks,
Zorro

> 
> Thanks,
