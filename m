Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DDA3BBFE
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882065; cv=none; b=ATd/nPd3VyGlXIInAcIdohT+1jIovFTpjQhanfLZYd5JMsj7/fAAwN+9ZanD2fGAid1AV9R5qKK+yX8rAVwSrVRNpF1/3wlnau7AWHVlKRGVceFcsxN7sYwONqK1XyH4ygDEeXRhBciT+a6JWMjf8ytC/yz33yRi9Kgh07dXuUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882065; c=relaxed/simple;
	bh=BtplPilykSDmXEPAIcwW6SPb1HSAYs9BGFM+17sg+/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqqOZr9Z8q+Pa3A8mXzC/8KWbun8QK90EXvInQYMg+w5BqbehDAqkuWFRZh5Q4Mu7TzyARmTfXyyc8d5i4SSatfoTsrPdazgy6+OnB7/nR7ED8XGVRp4Ee5bDLcE8pkwiRjeHow/aEdmeuEVJdGNJckxD6XyyzkUsjr7A4gWg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wP0tn7oC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wP0tn7oC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1+slCauSmxcUq/zbqrgK2JfKIUMziQv6K/8nq1RMmXg=; b=wP0tn7oCf2F/esddzAtz4M0OEo
	l7z3gaEWpOnBlCRJuI+YWI2LXxROAb5QmpgTlRWQiCSGqu1Cba4PzAc714Rphs1zpBast/Dr/2Vd+
	oDXNZXT3jl5i3xPkzO0i3EISOdtI4asNNrccXViMq7MtYkyBamp9P/N1NVNlPHNZzP7pFEQw8fSB2
	lUJHHlYMWJtj3rK05c0uKHEk2CCMH8Kk53yB41QpyNfZfcA0qxSyF03SZGTJS0kb4dUOklYgQ6Ehg
	A7ElV2NHtt/12BE+CFVkajf6p/qG734iO4Kg1BfQxDv0TGJrX5MCRR/Gz9R9hmiQLL4T+FxiJTo5q
	8cz2a28Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmgZw-0000000EDFd-3b2J;
	Tue, 19 Mar 2024 21:01:00 +0000
Date: Tue, 19 Mar 2024 14:01:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 5/5] generic/733: disable for btrfs
Message-ID: <Zfn9DMR8UQQMiyiL@infradead.org>
References: <cover.1710871719.git.dsterba@suse.com>
 <094a1bdc304b236ba41aff4da454abe3c93a355c.1710871719.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <094a1bdc304b236ba41aff4da454abe3c93a355c.1710871719.git.dsterba@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 19, 2024 at 07:12:10PM +0100, David Sterba wrote:
> This tests if a clone source can be read but in btrfs there's an
> exclusive lock and the test always fails. The functionality might be
> implemented in btrfs in the future but for now disable the test.

Well, this sounds like btrf sis broken and it should fail?

>  # real QA test starts here
> -_supported_fs generic
> +_supported_fs ^btrfs


and just throwing random not supported in generic testes is just a mine
field.  You;d better explain very well why something is not supported,
and do that by adding a _require_.  If you can't explain the
_require this probably actually is a bug and not just an exclude..
