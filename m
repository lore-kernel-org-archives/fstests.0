Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723F7279358
	for <fstests@vger.kernel.org>; Mon, 18 Aug 2025 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502051; cv=none; b=ulB/0OFLKIKxy4pLZKLq0Kzg/sGT5Mvn7NULJpPulrJ93S6bhz7XfaFfYiPO6+HNXvs9TUuOvllJwwaWA+CZ7WAZvMfw75XLJslLUrx2pQzoH5ANNBHQmrLkQLIaTsNq7SfzTuaIm8v99T/Nx+SP3fjIdsrqCR7I6NZxrykTLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502051; c=relaxed/simple;
	bh=oeCr2NHdFYkSpp3viomUfvIubwkvOUr6gjOCfrYGnfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQqgG/i/7pyd+1dl7Y2HC5Vax28om8cLkoDHXnoL62dXecXZ4Btld5SCn3oD7my3NiWR0qA+p/GYkSaZQMhdZHfjdSrMKZJwecqkKcLVwvGdx7U6K3P2ZpqT9LyJUtdx4wJXPFAQsBoNtowqwQLeD5Vlt+VokCcInEDnOaN0Tio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hTSnA2AK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hTSnA2AK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4oDRMI00HHXVsR/zf1dpDW2Ejm8eztgRbS+WvhvT8yM=; b=hTSnA2AKz09y2MJrb/yVcYc3ng
	Swxt3byV9ir/1PqVfl6usVnjZq4voaj1o0PV3dARKnGqQQ90vdimFBCpW9wXToUk2VqvBXU2UQtXk
	6tHibP7xoX38zbpg4l8i5G1xLbz14Dwwjsf8ukw47BUJCCfMJgsqeB6Qhdh8P4MT3BGdZee7i2nX5
	utG/zJUrCXe4SQNLAgy31Uk1654EjdJbEaZAAANSjR9ochtbHXS7LT1eLSoTg/FVOSZnduG2h7Rx1
	aNZ5GyHe40zJ0DIq4xpGWCni+qyySA8zMu8DZXdkuS2/rriI1VGy8JkXdeIOK6Vdixl6YY4Hq3J3q
	Wj5iBltg==;
Received: from 85-127-105-248.dsl.dynamic.surfer.at ([85.127.105.248] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unuHA-00000006mkF-1Uux;
	Mon, 18 Aug 2025 07:27:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: fixes for running on devices with protetion information
Date: Mon, 18 Aug 2025 09:27:15 +0200
Message-ID: <20250818072724.1559133-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

currently various tests either hang or fail when running on devices
with protection information.  This series makes tests using
unsupported device mapper targets _notrun instead of hanging or
failing with obscure errors.

Bote that to usefully run on devices with PI you'll also need my kernel
patches that fix a regression in PI information stacking and the
one-liner to add dm-error support for passing on integrity data.

Diffstat:
 common/dmthin     |   10 +++++-----
 tests/generic/081 |    3 ++-
 tests/generic/459 |    6 ++++--
 3 files changed, 11 insertions(+), 8 deletions(-)
