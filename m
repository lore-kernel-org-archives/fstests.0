Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202878;
	b=tNy3q9+vcYh5YU+c6p9La1jvU6v2225nCp/FLf9DYY2We2v6IFO/klAwqbpj9ZaibNJ4
	 BDWYn6oBNrKVfIPFcJxkxCnQ3E/jNBOu14aWo3KRAc4xD9+7gudGeRPVGiO3RlzbTPAOH
	 3payp9LZIfIKHEtQjjmWXlSUShb8esfBXA13zyBg2FL4DyEHwFyyopRTr30ABCok/5NQl
	 gvqK8kHFf61Vzr2js5GhUEboKfFerkvIByDns5nV2x2jxU3zplgWLPAj8hf3y3P4CgUm3
	 jHlaA7F3xeGk+CTZ4CbFWuumv/j0IHmlh5BYnoYhUs6snb7mqIQ8woh2OWwfApxao/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202878;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=422HFN53Nwu1wgQaRKxujkAntjQ1/boKZzysS2TQQLk=;
	b=l8rXBZ732Ndf9R21i0ACcl15kty7P55PZvD5liwINEjGJAUggNQAMGwE1bXPQ4svoXnv
	 BBxtDFaB0YbmefJOabloZGUDtHPxNmevaSlx1Nq99ZuGtn3sHDpIWTLHEpEQ7wRsVDFj+
	 vCIeDlbz204kMkWWMnu8eMBQa5xP2h3GFCrTj5Pse9FLiNw8HTregaCJ53fXg9mI9n6Yi
	 HeXiNDv9ih/apHGi/sGPQHLsBrlINEnt/gbeFPYf7uaZm9gtr+TYgrd/RZ8eXp2HIuK9i
	 Yau0ZfUc8Q1ziVF3D1cEs1e5BUFFKozvA5N8/wZBJkUB4bbYV22n7MAClJ2tiEQvBjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Mc4HRCpv;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C41606A31F;
	Wed, 28 Oct 2026 15:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3C41606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Mc4HRCpv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=422HFN53Nwu1wgQaRKxujkAntjQ1/boKZzysS2TQQLk=; b=Mc4HRCpvDrCW9WLE2/g8ziQ7hT
	qO4gECc7MZn81ADg1ZeptLLUknbNXHkjuG2egQFOzO+D3I5y6BDvWQbaH8NmptdODVAOkjtuagxRj
	h1bNltaq2C6vsgV/5Nek9/evtQgcLWdrUZGK4/pyETMT3RPtqetOJkSRToHQX6hiFg2BPxyo//sY7
	ZKny6Pb+0TECmITg60qJK88APogNvVcsC0xuCHiyDEZpYTaMd7ZS8fAb7/B+l9HMNXifreRLDJvAd
	luJvJqBJHH3iAlxOB8gwwAku1fwv9s4v4G8WG+msY+T4I1ZMdt1E0g1pJ5fOdnvlK8jAXZl+fA5Ef
	pl5bZqqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5z3-00000007THx-1ie4;
	Wed, 28 Oct 2026 15:54:37 +0000
Date: Wed, 28 Oct 2026 08:54:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC fstests] generic: add a test for multigrain timestamps
Message-ID: <auIavey7CFq_l38s@infradead.org>
References: <20261027-mgtime-v1-1-ec68914a116e@kernel.org>
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
In-Reply-To: <20261027-mgtime-v1-1-ec68914a116e@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 27, 2026 at 09:58:50AM -0400, Jeff Layton wrote:
> Ensure that the mtime and ctime apparently change, even when there are
> multiple writes in quick succession. Since this is opt-in for in-kernel
> filesystems and there is no way to test for this feature in userland,
> limit it to just ext4, f2fs, btrfs, tmpfs and xfs for now.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> I'd like to start testing this to make sure it doesn't break, but it's
> not universally supported on all filesystems. Is an explicit allowlist
> like this the right approach?

Can we please expose the fact that multi-grain timestamp are supported
from the kernel?  This seems like it would be just one bit we'd need
in sttx or something similar.

