Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BABC00A8F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Oct 2023 06:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjJXGjd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Oct 2023 02:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjJXGjc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Oct 2023 02:39:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3BEF9
        for <fstests@vger.kernel.org>; Mon, 23 Oct 2023 23:39:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D77296732D; Tue, 24 Oct 2023 08:39:27 +0200 (CEST)
Date:   Tue, 24 Oct 2023 08:39:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] dm: error: Add support for zoned block devices
Message-ID: <20231024063927.GD8472@lst.de>
References: <20231023224513.344380-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023224513.344380-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks, this looks good to me and fixes the problems I've seen

Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christoph Hellwig <hch@lst.de>

FTI, this is the xfstests change we need to use dm-error for zoned
devices in xfstests:

diff --git a/common/rc b/common/rc
index 741579af..9e07d79d 100644
--- a/common/rc
+++ b/common/rc
@@ -2174,12 +2174,10 @@ _require_dm_target()
 		_notrun "This test requires dm $target support"
 	fi
 
-	# dm-error cannot handle the zone information
-	#
 	# dm-snapshot and dm-thin-pool cannot ensure sequential writes on
 	# the backing device
 	case $target in
-	error|snapshot|thin-pool)
+	snapshot|thin-pool)
 		_require_non_zoned_device ${SCRATCH_DEV}
 		;;
 	esac
