Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59716CD05
	for <fstests@vger.kernel.org>; Mon, 22 Jul 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658018; cv=none; b=k+UPXMC12ynbybJ2QheDu9Zzfz1/u4JFi636wjNCF6+mAFzzsTNt5CZLCgVmFYs6IxYUXPk12THdCtVV8cb2ufh5NX87UosWYBaOPA6Qs61DZzj6PwFKpd+i8JA6zi7RX0I7MHsGAqvU5x66kCx6T9dt8aiVsry2yPZyh3tQm5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658018; c=relaxed/simple;
	bh=c5/iOZTcEWB21ugKXLu8yjje/DF4/w3DOgZ86TKwS8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQnytuTuWOVSdTdeMJdoY+/kYoK0ukr2ZzyI3cmCXOZBhaYoedRnzkvq4oferZkKCBgMabC+wq06WXbFdrAIGYWAoNf0iRwJq0BOwB0QlZztPMpRAoueBTbEUNdaLhhz24mSijs1+LwVn+TksDmX2icAzmQo4jxTO/dRFBSrm/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P2C6EHKq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P2C6EHKq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EpF/qdo6nPhJ/THyNZJXGS066gxbjeU+rIEka+KJAyU=; b=P2C6EHKqH5R+sWSYOheENeRUj0
	ngQ2svDbvqdOOYITAQ3naBFYXGNarLsq8yTO6gInz6kG0dFwIN9TCsTJhy1PDFYyq/qrDoUnldhbD
	hL+1QDfM30ZJLJv8t9FmPTEIY5V8/pmrCf9WfIF+SjG7wvp0bdrNrpVKts1gBpx2tsaPI/dNmX85b
	UoAdqEglywD8CznOtw9A2Bl4DL/R880btMA/wBmlyu7PAUpPpL6C+AWkWA5kXczoCVhlkrjqJfOYt
	1l+a4AqnBKWUysvIRbOkdHMvJB5l0DdyThrqAok5Wtc1Pu+aVQ0AwFA4U3T4vgyfdaILK5502Y5wc
	BtbnxAHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVttd-00000009khD-3eYo;
	Mon, 22 Jul 2024 14:20:13 +0000
Date: Mon, 22 Jul 2024 07:20:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yang Erkun <yangerkun@huawei.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-mm@kvack.org,
	hughd@google.com, akpm@linux-foundation.org, yoyang@redhat.com
Subject: Re: [PATCH] generic/732: don't run it on tmpfs
Message-ID: <Zp5qnY-C_GXnn7ts@infradead.org>
References: <20240720071323.2893437-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720071323.2893437-1-yangerkun@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 20, 2024 at 03:13:23PM +0800, Yang Erkun wrote:
> Like what 4fd042e0465c("generic/732: don't run it on NFS") say, the same
> options for tmpfs won't share the same backend. Skip it for tmpfs.
>  
>  # real QA test starts here
> -_supported_fs ^nfs ^overlay
> +_supported_fs ^nfs ^overlay ^tmpfs

Can you please spell out the explanation here?

We should not have a _supported_fs call without a comment explaining it.

