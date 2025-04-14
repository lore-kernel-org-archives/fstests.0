Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970711684AE
	for <fstests@vger.kernel.org>; Mon, 14 Apr 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632070; cv=none; b=Z0C+l1HzXsaG2fr/RzTgrOKHYVLgru0ySYQ3v28Tm3j58uCLQLL9BRKux/mDBlqWifmbyR0i8OPC9chpoXys8D2EEML4/Z0+KKYoqily+y917dAIwZncFIokr+Wtsgfoytz/X534VzTSxL2kcV1MW6xrd3VS7KKpCWNt3sfoLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632070; c=relaxed/simple;
	bh=I+klAA2zsTEXVvXmA4sF/V4coFMP8mRBAWZ+cXPZnEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDxn38rWjgys9ik85bsX7OcOGS/Whol5l61OAWdtS1x5HnKqjEPbarn55ow0dmKm0b4WqNG9htCczAYb0+Coz+1JInpTFKj1tljbn9o1fM32IonZq3vH+/MuGjiV9IhnlTfB52aTSpngz/JGXAqNUavnTK5fITp/1TP6NKn5j2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0xIC5OGS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0xIC5OGS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CxDChfgyFdNm+GUtonMfHklN2MQ01DvIsX7sdvLLMOI=; b=0xIC5OGS9OEhIyU6K3eTHDZGx0
	f+G0LBZBHcg6W6Od9IKKywZrfjIijqOgZ1ZpmpYr6vdc7lhbPdThfLmj+UgosLSo3dgm57Ue4nLha
	GkK+cKKC/qrTIZtvP7iBWtq3EaaBCse3wpiMM2Uah/jhpNWL75wVPDlabo1Fkwl8OWSgcqFlEbr5b
	84mMT/frSj0Mjx1fQwvTHsReCYnGJSFy/0OxHOcVINNBVZ9i5feCYsRaa7DFGQwNwC/l75cDH7S/m
	aaZjTLO0JT1LWUwtmSc+GgjydNedWeHUDOsQpMF8u1KubIQhsGuvQFq01O53pZPw8wSGq5Phchv3R
	8EcUQu9Q==;
Received: from 213-147-166-27.nat.highway.webapn.at ([213.147.166.27] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4IUt-00000001rnI-2MXK;
	Mon, 14 Apr 2025 12:01:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] generic/231: use relative path to invoke fsx
Date: Mon, 14 Apr 2025 14:01:02 +0200
Message-ID: <20250414120102.400383-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This test uses su to run fsx as $qa_user.  Because the shell calling
fsx is run as $qa_user it might not be able to access the xfstests or
parent directory which might only be accessible to the user xfstests
is run as (e.g. root).  Switch back to calling fsx using a relative
path, partially reverting commit 1c67e8b191fe
("config: add FSX_PROG variable").

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/231 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/231 b/tests/generic/231
index b598a5d568bd..8dda926d875e 100755
--- a/tests/generic/231
+++ b/tests/generic/231
@@ -23,8 +23,8 @@ _fsx()
 	echo "=== FSX Standard Mode, Memory Mapping, $tasks Tasks ==="
 	for (( i = 1; i <= $tasks; i++ )); do
 		SEED=$RANDOM
-		echo "$FSX_PROG $FSX_ARGS -S $SEED $SCRATCH_MNT/fsx_file$i" >>$seqres.full
-		_su $qa_user -c "$FSX_PROG $FSX_ARGS -S $SEED \
+		echo "ltp/fsx $FSX_ARGS -S $SEED $SCRATCH_MNT/fsx_file$i" >>$seqres.full
+		_su $qa_user -c "ltp/fsx $FSX_ARGS -S $SEED \
 			$FSX_AVOID $SCRATCH_MNT/fsx_file$i" >$tmp.output$i 2>&1 &
 	done
 
-- 
2.47.2

