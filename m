Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA814D283
	for <fstests@vger.kernel.org>; Tue,  3 Jun 2025 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932176; cv=none; b=V4O1FMQ0VDQ0aD15fnCvVfRu4jF7wZHMXyIvEvuMUmO0DOnF6pDj19YDrCd9KtYvAMdETAYJND40U8WmH6yytl/sZYhHXZqWVg4mJWFBooBVReEaNI+1Denu1CfhIoqeglu9wZh5+zE0usePkeDtO+4hzPQVe5mN/cbG7YAs6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932176; c=relaxed/simple;
	bh=3I96r6+4zyZNWEX7sB8StbifoYEhS9ISxbgqSPX58fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1ZQxXPm2sQPsit1xexofJi2uF+2ucnQRGQD5iEXRpmqRfZ5N591P14vsm2L5Inw21BemBdliD+5XUS8Zsn/+8PcTsQ6uwbnCamhxLGvYw0XaelTJx7REtE1JYXpMx2Mu2+r8u9jgpdozkEMfPDP+dm3X3i6hrJt/DeBE3NmT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tk+F+joh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tk+F+joh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EEedx2nT57MR1QtLi+AVQP4P+SM3cUo5HUMEqezgfW4=; b=tk+F+johEyHneovGulz0atYs0t
	KcDE69tL39uVpK/MY8QUrsdDMFFAA0ot8xnfX4fRocrF26/pTe4tcROwOTkEV9VSJr/w5n+De/xGE
	PKTg/hdaGE1c/9q4064Euff/AnaxeZl+6qtNZD3MNnK9naJmZ7VroSSgDSPyDzET6cOSAZfby6YKu
	Khj77AWtsNRLFczCyqDh6lmqGy6iSpru3coCDBZlmt++Kgc48IgDzIegxbvivpwBNSwClZC7Qfemt
	r/a062Qs5/gFz0o7e25wmG2iHVibqgqyquPDOuBIcTxqjHIvxI7VhgOuyj8GQSqjr9xiJxdaUvVw8
	HbestVFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uML9O-00000009xx5-318Q;
	Tue, 03 Jun 2025 06:29:30 +0000
Date: Mon, 2 Jun 2025 23:29:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"zlang@kernel.org" <zlang@kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"Friendy.Su@sony.com" <Friendy.Su@sony.com>
Subject: Re: [PATCH v1 0/7] add test requirements
Message-ID: <aD6WSkbLt7__Ohuq@infradead.org>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <aDbs_Fr-8CVCxdxy@infradead.org>
 <PUZPR04MB63163EFBDDF33FFC83B863008166A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <aD0514qLBX-MSazZ@infradead.org>
 <PUZPR04MB631648D55D06ADFEF408ABA9816DA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR04MB631648D55D06ADFEF408ABA9816DA@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 03, 2025 at 02:35:04AM +0000, Yuezhang.Mo@sony.com wrote:
> Yes, this patch set also for other file systems like exfat which do not support the
> above features.

So is this for exfat or "other file systems".  How do the results from
an auto run with exfat look with these patches?

