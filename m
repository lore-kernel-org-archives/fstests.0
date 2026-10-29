Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275375;
	b=4wradKbAlYtuyTlhVftbPrHBKssUR/Jyi5GuNaK+CuxKA3EN+Y8NpkA5ugH3wkbfx8Xo
	 yq3LuSYUslwhwtSLWqJtxemmgQrBN+FIB5YoVpL+a/3MEJbcPlQ5FVATvNd++V6lrXIln
	 AUtwHqVsgKzraxIe+wowsdfONT6VPs1izPFNEh0lRdY3ORuVz+4uF8qDPagxenzHI4/NW
	 hxqwyG8wgUdPnuyAFxWsuEGYUmfWauynajzfFtNyCcYdH/0WBONegcced+eQEYO/9Z0VG
	 PTuc9mD+3Nc71HWQ+zN8RPYiNWYGgwUS1gfhm+d81t+HRb1HtxlkariAoavO9JlYScQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275375;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=+yvgd/z3YW5tkast/LSe7BMSvA6NVM/2yRS3HdQVA/Q=;
	b=uBZOkzLZXiu9l9BOxX/A0yU//wr6tT1It4fAccRO6Nd+wpDjAZ9R7JY0SVSYPf3LmpgT
	 Xiu26U1LpnPXwcUDz+PQSHczdWRuA7dkvRYgC6XEuUL1Japfw8n2krsuQ0U3Vhv4xY7Do
	 CvNIfUccP5EUTY9rw/YYp/nFU2uih3Gw0ej/qm5Vxofokq1XvVjHmbAPxfYnPmKN5wawo
	 LuiEOHz4AtzXl3QLlp9voERbLEuUdmArUH4rmDRRr1bsyGu9QdHjdFmDJNp/IyAuV0l2m
	 eIJd1FxkpFEmM5/K7R2qxB8h1fRSFFoHXjYYcglJfwU2DdTmYkHsGS0dKOD88VjlSBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JH5mIL7p;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B33606A323;
	Thu, 29 Oct 2026 12:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B33606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JH5mIL7p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+yvgd/z3YW5tkast/LSe7BMSvA6NVM/2yRS3HdQVA/Q=; b=JH5mIL7posg4WBBnTyj1o5Afhv
	7+LRTfuRA8iaoc0XiUF7DVHPCVb/wTFG1hU4MYC4GnWEqQao010Gcwnd0yrixifhPFpDhpO+URP8z
	RZxqWzjLHpS0cAACLfCOIXayrvjrPQShUGMkHnbWEQyAaoGafYRg/x9Ya4ey1wfssUL0W7tTK3N/d
	hihUlitsENBzVUZQadMgtC13kp1xiilwzTdCshisWPHF4bJhRk35FNhNtAbYA2Lopah7pDThAPOHN
	8HIVLugEtA9yh7cz0z7BBiLQ5ddQIxVgnMoWxTBjZMamzzDu4BZsAeeKTGj6CUthkvsQcuWkd+7z/
	TNHMNINQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMOqK-000000096kH-3DWG;
	Thu, 29 Oct 2026 12:02:52 +0000
Date: Thu, 29 Oct 2026 05:02:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC fstests] generic: add a test for multigrain timestamps
Message-ID: <auM17EN-wLboV0WC@infradead.org>
References: <20261027-mgtime-v1-1-ec68914a116e@kernel.org>
 <auIavey7CFq_l38s@infradead.org>
 <3a5b0778c77df7cce94bf9fce974b1bf1dfb6324.camel@kernel.org>
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
In-Reply-To: <3a5b0778c77df7cce94bf9fce974b1bf1dfb6324.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 01:20:24PM -0400, Jeff Layton wrote:
> On Wed, 2026-10-28 at 08:54 -0700, Christoph Hellwig wrote:
> > On Tue, Oct 27, 2026 at 09:58:50AM -0400, Jeff Layton wrote:
> > > Ensure that the mtime and ctime apparently change, even when there are
> > > multiple writes in quick succession. Since this is opt-in for in-kernel
> > > filesystems and there is no way to test for this feature in userland,
> > > limit it to just ext4, f2fs, btrfs, tmpfs and xfs for now.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > I'd like to start testing this to make sure it doesn't break, but it's
> > > not universally supported on all filesystems. Is an explicit allowlist
> > > like this the right approach?
> > 
> > Can we please expose the fact that multi-grain timestamp are supported
> > from the kernel?  This seems like it would be just one bit we'd need
> > in sttx or something similar.
> 
> I'd been resisting that, but maybe it's a good idea. I'll see what I
> can come up with. We can probably just add a flag to stx_attributes?

Yes, ever since STATX_ATTR_DAX/STATX_ATTR_WRITE_ATOMIC these don't
seem to be tied to actual inode flags any more.

