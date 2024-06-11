Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E9433C4
	for <fstests@vger.kernel.org>; Tue, 11 Jun 2024 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718084503; cv=none; b=tYTZkkewD0OjhXZPFLN1CxEGApojwDMk7XBVzKcXWv2nIReQLu8VuVbx3lWFWOZyss7pkRkFaxandqPPbQNxNTftxFd2ma7wyTW0g36l/uhLpZGIKE8HirK3kY6rEeTmKtFjZhFh7X1GyX9/Mxh+44LVxX3AUVbk00vWJ7BJXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718084503; c=relaxed/simple;
	bh=LC+UQSSGgiKI+QLNK1zFpaDBOO8frGNFwiqLxB+ImyE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gVm0Vc3PqO0X5O4ZhdpLaZK+IPkj740vVFXv7P52os+ZqXJ8fyPbQyb1dYCxRf8CkgWporr+Rr6u+aNHudZMXB9rwADNM1no4N8XlPcB/2Wi3ykLRrT+fcB77bXiYcaSLflu8chKuEl1mTuK8jP/XZJVfgL94/LNh5Fi7zqftGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H18eVExL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H18eVExL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=CovL32tAp82u81N7/CdxgFYduCjDXtGl1V7OtoxPCXY=; b=H18eVExLsbyWcVbapO8IquWxm/
	29vI4fYj9mmKrRdETSmw37Flv8p9oS9vsjhbqtktEeHD6gJC6T/TdK5Be9FyODno4cWRHG6H+eD4w
	sooHfhUWIq89YjNAlmk0zR24GLqv3Y6glhqbMD2Zzx3nuRIdoKjmNsp4+oaXrIbNCucEXNODSVf0a
	nnG/lKTdSydYAvIeHu9MMhNdxhD2pG3ty1+x3ZYizinxG3EMmod05yYAzBQFzcYzvE8vOJZ6utZKq
	L1nciORpwSrL5uC3EwYkvmfaJo/1CCZwzp5y7mKKijzsdWTvGcVnXPf04zov0Gd0laUzRj82kiiBd
	JIwaUQuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuGL-00000007Z4r-3SZG
	for fstests@vger.kernel.org;
	Tue, 11 Jun 2024 05:41:41 +0000
Date: Mon, 10 Jun 2024 22:41:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: fstests@vger.kernel.org
Subject: can we pull in git as a dependency for xfstests?
Message-ID: <ZmfjlWGk04r_R5j6@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

xfs/073 has been failing for me for a while on most of my test setups
with:

diff: memory exhausted

from the recursive diff.  Switching to the significantly more memory
efficient implementation in git diff as in the patch below fixes this.

Would it be ok to pull in diff (including a supported check)?

diff --git a/tests/xfs/073 b/tests/xfs/073
index c7616b9e9..85d8ae8d0 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -76,7 +76,7 @@ _verify_copy()
 	fi
 
 	echo comparing new image files to old
-	diff -Naur $source_dir $target_dir
+	git diff --no-index $source_dir $target_dir
 
 	echo comparing new image directories to old
 	find $source_dir | _filter_path $source_dir > $tmp.manifest1
