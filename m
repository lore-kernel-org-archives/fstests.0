Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5442C3242
	for <fstests@vger.kernel.org>; Tue, 22 Jul 2025 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168777; cv=none; b=nYd8yXf7fdIsWeneeQKPps2/i/tAmqIznLFaSqvpkuu++f+d3RwRlF6h6QHmROmp/zJeMyqUQtkBcDdQe5kyQ0V/b91o38vJuaEcttnlQg07vlwqHoHLixVVqi8Bt0zzZtCW9Qv8JUCV1SNfU9Lix+ygcXHZhZk/AMZvs+aI3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168777; c=relaxed/simple;
	bh=mrNTsoG+9ire1zZd4IbkwDWst+tFkR49AOBEGT3lW5M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dbNSEgWwXHJthuvee965Uo1vy16r627JNmtusqxZpBtrq6nedIexfRapvrlFQm7xQP5GZnpzL2mpzsz7OMAqE91Wesv2RCWgsMG72yWR+LvvZ4XZUnBArAsBdh4DDUWoGJfxjs3RJWty5bXSehX8Wja/gcxbwiLsGTE0zusCMMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vQy6sbHv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vQy6sbHv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=cna0rpTem3f604591N+DeP3Nab31y1HAtxAU/K4AGDI=; b=vQy6sbHvIkS+CvxRYkf1LwYRUC
	MHilwmxZIon39pfpblJlDBaHpy2oYBDAOc5NectnDQDomI1VQHUUWDw4uXv3wUuoPtzOY2Gup8nJB
	SKfSgkX55u2C5nDjT8/P3Nf5Srtxs0AhI0a4mPMiHf9mVhKPobZ68ukW8igAKE+VIvH+az+2eeYHR
	Q5o2OMV41dVTOuqkmBQhTuY8oZUDOb65Aon3iwqwwYU/vDWEbQ7ib5ASfZiooHEXWUceCT4WNfP94
	e1XStnsvg5+V5qlEhnACKn60VBTADdQR0sFhNE+8iBgXoX1fPq2lirc2wewkef9hXbRnzENB7f2OJ
	zRoBhcFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue7Hi-00000001axJ-42Ec
	for fstests@vger.kernel.org;
	Tue, 22 Jul 2025 07:19:34 +0000
Date: Tue, 22 Jul 2025 00:19:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: fstests@vger.kernel.org
Subject: lots of mounts/remounts of the test file system?
Message-ID: <aH87hl9NUmiqqvU-@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

I've been hacking on some (XFS) code that in this state of development
requires a mount options to be passed for every mount, and I noticed
that even when running without a SCRATCH_DEV I have to add the required
option to MOUNT_OPTIONS and not just TEST_FS_MOUNT_OPTS, which is a bit
odd.  I've been trying to track it down and despite multiple attempts
failed to find my way through the bash code for it.

But what is even more odd is that when running just a single test (e.g.
generic/001), the test fs gets mounted four times, with the second
and fourth time failing to apply the mount options.
