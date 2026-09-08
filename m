Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64A54CF7E
	for <fstests@vger.kernel.org>; Tue,  8 Sep 2026 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878037; cv=none; b=f+YhsL6ZNsMttRf/Advl0GABvbe7QrA3a/gsr3WfWfeGA+91fIv9XZRzoSrpxVswiW4Ic4VERENH8RZtSQ82rLhJVSwkTsdsKkNJiHZY3BvgZdOEfmBkq2eK0RQqQZKt0QJ+FK48RrvdemjNb50fJpIltht3smD6C3E3PkQufqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878037; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=P3q6RmCP+0bhDVVad4ZjADTttHOaoHK6Bwk2Ps5mO80RyckXp+Amis/Cq3YwZpl5MnUOiBpsNa4QEK2uStfyoP+bucvg1/2lm5cZFQLUCBFqbsEjqQRogs3F+GPg9GqKHNVy4bzF/YNs0u7ActFoBSC4oKn7YWyR+clgHnalnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nrJGJs6s; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nrJGJs6s"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260908143334epoutp0492b333e12f17c8fe8d5f50774e26f929~TXxOQpj501515215152epoutp04G
	for <fstests@vger.kernel.org>; Tue,  8 Sep 2026 14:33:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260908143334epoutp0492b333e12f17c8fe8d5f50774e26f929~TXxOQpj501515215152epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788878014;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nrJGJs6sqVhOaxEvT8dTQ02jjV/bxFXD7+LimJ0d9wvEdZy0mzGe4yVhe5YSEVFqe
	 F6inyu8w7KV0U14Efc+l/mkEg5sGnGwB0xZyVyrnu8PofxWRe9yw32bBzZim5uvwIP
	 7vO58XI3hCdCea18L4BRhqzSbUhVsfti/pcNQXoA=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260908143333epcas5p37538426ce635fea9cdb24870601d6448~TXxNYqBdB0811008110epcas5p3j;
	Tue,  8 Sep 2026 14:33:33 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.95]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4hfRJF063cz3hhT3; Tue,  8 Sep
	2026 14:33:33 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260908143332epcas5p1a0aeda9d74f18a8ca6037b383e441d63~TXxL7EqSz0873608736epcas5p1-;
	Tue,  8 Sep 2026 14:33:32 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260908143330epsmtip26a1203323db9cd1337b5967c31eff8bb~TXxK370kI1996119961epsmtip2d;
	Tue,  8 Sep 2026 14:33:30 +0000 (GMT)
Message-ID: <f14985ca-3900-4700-a5fd-e6492403e309@samsung.com>
Date: Tue, 8 Sep 2026 20:03:29 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] add a "pi" group
To: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, John Garry
	<john.g.garry@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-scsi@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260907075822.749818-5-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260908143332epcas5p1a0aeda9d74f18a8ca6037b383e441d63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260907075858epcas5p4d59f2327f7ef44227c3b8bbe3367c12f
References: <20260907075822.749818-1-hch@lst.de>
	<CGME20260907075858epcas5p4d59f2327f7ef44227c3b8bbe3367c12f@epcas5p4.samsung.com>
	<20260907075822.749818-5-hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
