Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E32ECEB9
	for <fstests@vger.kernel.org>; Tue,  8 Sep 2026 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878051; cv=none; b=h8rbQ6tiW7xPLPgHaFXsy1Dft07QMyVnDZ88bqhR51AYN43ZnNQHdWLfZgATo0xf8Rq9OaHh9yAXohYhOOqMhtuwbQQ8hPDQciWWW3W3vVeSYPX7CQrVwMIcfDP5XaSahQXmc/CTQ0ruoUe1n+yZbt403X0MyjOwae6LJsmj+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878051; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=cgNAFbwC70Q8cxuLRuQu+CnEASx2XOtkvRoSd5MAcRvTw01FB8rwhX3ciMeIbhZPmldWlhM4Defj5bYGmtuxeqgg9M5a39w/UGBz3JKO3YsveU7ncUaqIuRJMGQGD6EELYdBGye90xDMbDl0icK1Xl/C7KEX1iRAAHjIygn7ZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j14uRIBm; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j14uRIBm"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260908143355epoutp0457c1019b8a39f34dd36bd8c2c1490fa9~TXxhpDdnA1446214462epoutp04h
	for <fstests@vger.kernel.org>; Tue,  8 Sep 2026 14:33:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260908143355epoutp0457c1019b8a39f34dd36bd8c2c1490fa9~TXxhpDdnA1446214462epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788878035;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=j14uRIBmNqgKdOwRUdfZh0RvDjXzcqP4LHM0zuE6UD3I6UpWt2LdRTCXjf6D8RyMy
	 4I+JSw4Uz+7ItQu5K8bto3p+zT6R9FbBEH7SD2qJHaxjU6KDQ+WWvP0eZ7Q8SGn5pU
	 5M1f3gDt500bq0h4K/nGFEFDi+jcehb3KMxs2Q7k=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260908143354epcas5p4c9b097b64f1877e080ef73f5c5c2ea54~TXxgeSeSb1911119111epcas5p4V;
	Tue,  8 Sep 2026 14:33:54 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hfRJd5MX0z2SSKX; Tue,  8 Sep
	2026 14:33:53 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260908143352epcas5p3b4f4e1114aaecfd1a63279751efc0da1~TXxfUoLFc0811008110epcas5p3A;
	Tue,  8 Sep 2026 14:33:52 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260908143351epsmtip1eae586de571a1ee7fdf7e0dd38cf6cfb~TXxeLVEMl1781517815epsmtip1k;
	Tue,  8 Sep 2026 14:33:51 +0000 (GMT)
Message-ID: <a5c80553-304e-49cb-9563-a8c2d2a402d4@samsung.com>
Date: Tue, 8 Sep 2026 20:03:50 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] generic: test I/O on devices with T10 protection
 information
To: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, John Garry
	<john.g.garry@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-scsi@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260907075822.749818-6-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260908143352epcas5p3b4f4e1114aaecfd1a63279751efc0da1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260907075907epcas5p411353bb530143645be97b2a9c898c544
References: <20260907075822.749818-1-hch@lst.de>
	<CGME20260907075907epcas5p411353bb530143645be97b2a9c898c544@epcas5p4.samsung.com>
	<20260907075822.749818-6-hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
