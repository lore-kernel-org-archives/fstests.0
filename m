Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627EC242D85
	for <fstests@vger.kernel.org>; Tue, 20 May 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750140; cv=none; b=b4dqeXoPYHVKsDwEni5dk3i+iZ/EwfHlcOmMMkjYJ2o1L0pdCbXIRCq5HRibaRXxImHV7emHdSLvjHzyAJnzpoa3tKek2r+mwofBu+qry2OIzcFOI9Dj79hKcvnsTg5DL0dJIPW8A9y4SXO7Vnay/h35slI3J5gKX4Bzfr0AwPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750140; c=relaxed/simple;
	bh=dzrcAoSATR5IqT7A/EbJNdOLgUgJ9CEnV8VyLzDdmY8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BJErzNL5MmtolyqZV9+opqcw1ZCyHAG4yB/9PKQZQ+Q/2lcUn3FRRFI17QIX3raOM7A5NmlGDyMuFJ0gmQ+7NpXNP8+/XG3coCuouHVvU2IYIHz1WwmDqcEBVDbNLJ99ya3txsDiUp4XCxhMNWPACvJocgzQyjL75nBesgv7oHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bmj4azBl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bmj4azBl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=atcbji7K8wVrrwGlTh94zn6jWdvwg2eM1Y3aBgSsH7o=; b=bmj4azBl3ryGQIcXNXUMnKpzI5
	DZsE0KQrYEU4+XdMglQdphpCe94U0+jvw+2G2GYvzOQj77kFmBkqqyAq/On4jcg//GG/2jNKvaUq2
	poK9dajNJMFsEMceOhvxtiaEErfttHY9GeKd86TlFHZn9LFTpvNuqwD+27/mJ/yc0iSdxk5fapElP
	BmaEOH8Ds5Z4yrgJPxj70Zf8pwKNf6X+Fjjn3+AtdMBdNEkMBGqYEZm+pJyaU5W+LuCdt2/j2ieck
	Vcv0BHV4jF5xjFUPR46gydLfY1Z9nXNq+1FODPXSXEIgaKmPqSgIkRrXklvMb+11e/ZejzjAqjrCR
	oe6F3r9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHNeN-0000000D6zp-05Lr;
	Tue, 20 May 2025 14:08:59 +0000
Date: Tue, 20 May 2025 07:08:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: xfs/566 execution time
Message-ID: <aCyM-p06c99rJ04g@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Darrick,

we regularly see execution times of more than half a day for xfs/566
on a 30ish TB SMR HDD.  Do you think there might be a useful way to
scale down the load on rotational devices?
