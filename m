Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794538626;
	b=nf+EEfVHEiTlX6+uWz68bTY2rHkJt+A8UINnsA8sdnhpX33/l/q3Hq9DAmd57aQmDRSS
	 fCSgJBQU54UG3Ub75uD2z7kEgatpBKa9DciRjgYJNe8JFJbpTIFtcFJNXrgObAOUrrrxa
	 3itb+nqFdMN05uwYUZYDC2yeLnk0JAyT+25mga7yKDNNiKyASysQxjTwZJldYBjC5D05u
	 ojUvg+QP8JmMbfd00OvKrH7P8OV/4MrgpqqcMUb/VLUtjTmtHFi0GjRLXS0tS2Jtqn6Ji
	 9H0V2Egje2+We2MnvxywZ9/i2pKKgro+XIfCGTgHHNfh++6QA5ZIgRwUXqL10bSHCBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538626;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Mime-Version:Subject:Reply-To:Sender:From:To:CC:X-Priority:
	 X-Content-Kind-Code:In-Reply-To:X-CPGS-Detection:X-Drm-Type:
	 X-Msg-Generator:X-Msg-Type:X-Reply-Demand:Message-ID:Date:
	 X-CMS-MailID:Content-Transfer-Encoding:Content-Type:X-Sendblock-Type:
	 CMS-TYPE:X-CPGSPASS:X-CPGSPASS:cpgsPolicy:X-CFilter-Loop:
	 X-CMS-RootMailID:References;
	bh=ycCYr2y1perWAyUcIfRv6NhffRDJqH/MBKX0SCT8qfU=;
	b=ImUV8HCYfCkL+XxOeEBuh7sU5gKqHYLXE0MSizJaQSOZyAMNUzbhI66sTpPOQ4B8UntS
	 L3USOv+wDKvUugjZw/D0oRx3G3YmJmbHM0y2+ARe/r7ZE//6jx0D00eMiqQEn3z0gNaVr
	 5e8nlscBsCbZIiKxI/Q0yRECArWhY4PJy2SpMY1+M8XFl5mnxq2FrH9KsNyiXqklALSrp
	 6yeI70FRQHTjEiYT3o7tEtLBNcTwySPNe5B7J72J04kcoEiHeXueZ3nd42cJYw0hskM06
	 Mju4toJTHB4u4oL5K761792H95dYL3WND/D2OTHViPEXoljBvtlRYhcukspcGFbpp3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=bULfZHXt;
	arc=none smtp.remote-ip=203.254.224.24
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5D606A321
	for <fstests@vger.kernel.org>; Fri, 13 Nov 2026 02:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD5D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=bULfZHXt
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261113025643epoutp01ce13fee3069142279ce03c8746c50b96~ne1okZN8o1720417204epoutp01F
	for <fstests@vger.kernel.org>; Fri, 13 Nov 2026 02:56:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261113025643epoutp01ce13fee3069142279ce03c8746c50b96~ne1okZN8o1720417204epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794538603;
	bh=ycCYr2y1perWAyUcIfRv6NhffRDJqH/MBKX0SCT8qfU=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=bULfZHXtpJHTKM4a6E18RMwDwrv0iWWnB5aE+KDycrf/WCFOHlVjRxNe5ZIfoAIHY
	 AisXQZl7NmijCTdIP1H8ALl1br0TKyNhO2Qeo4HKyWDWpyB5uo/GHdomrXxOn/jZHR
	 wXQwntt2lfCyh5cFw07KFn1mN9zUaKaTyWTOOcJs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20261113025643epcas2p10e509a643c1d10f27687c7512aeed4e0~ne1oC-YuB3159431594epcas2p1k;
	Fri, 13 Nov 2026 02:56:43 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.210]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4jQhjk59TCz2SSKZ; Fri, 13 Nov
	2026 02:56:42 +0000 (GMT)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Subject: RE:(2) [PATCH 1/2] xfs/438: retry failed metadata writes again
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Brian Foster <bfoster@redhat.com>
CC: Zorro Lang <zlang@kernel.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Christoph
	Hellwig <hch@lst.de>, Dave Chinner <dgc@kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Daejun Park
	<daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <avXIstx55STwYao7@bfoster>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261113025637epcms2p7293f70d38c194bcc0484811c63137f94@epcms2p7>
Date: Fri, 13 Nov 2026 11:56:37 +0900
X-CMS-MailID: 20261113025637epcms2p7293f70d38c194bcc0484811c63137f94
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261112141007epcas2p462246c1d6a82b4540937ad955dbfd8ec
References: <avXIstx55STwYao7@bfoster>
	<20261112-xfs-438-dquot-retry-v1-0-73149b823246@samsung.com>
	<20261112-xfs-438-dquot-retry-v1-1-73149b823246@samsung.com>
	<CGME20261112141007epcas2p462246c1d6a82b4540937ad955dbfd8ec@epcms2p7>

On Thu, Nov 12, 2026 at 09:09:54AM -0500, Brian Foster wrote:
> On Thu, Nov 12, 2026 at 10:37:17AM +0900, Daejun Park via B4 Relay wrote:
[...]
> > +# The dquot buffer write must still be failing and retried here. A shut
> > +# down filesystem means that the test missed the hang it checks.
>
> Nit on the comment.. something like this is a little more clear to me:
>
> # Run a stat to confirm we haven't shutdown prematurely. We expect the
> # fs to be running metadata write retries. A shutdown fs at this point
> # means that we haven't properly tested for the hang.
>
> But this LGTM regardless. Maybe Zorro can fix that up if you agree:

Thanks, agreed. Your wording is clearer.

Zorro, could you replace the comment with Brian's when you apply this?
Patch 2 does not touch these lines.

Best regards,
Daejun
