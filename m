Received: from mx1.redhat.com ([209.132.183.28]:35141 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbcFTExO (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 20 Jun 2016 00:53:14 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EDDE80E47
	for <fstests@vger.kernel.org>; Mon, 20 Jun 2016 04:53:10 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] dmthin: express low_water in cluster_size not sector size
Date: Mon, 20 Jun 2016 12:53:06 +0800
Message-Id: <1466398386-5248-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

I noticed that thin-pool sent out "reached low water mark for data
device" event even before thin-pool device was mounted in
generic/347, this is because low water mark was set to a too high
value.

According to kernel thin-provisioning.txt documentation, low water
mark should be expressed in blocks of $cluster_size, not in sectors.

"$low_water_mark is expressed in blocks of size $data_block_size."

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/dmthin | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/dmthin b/common/dmthin
index 1b5c856..3cd206a 100644
--- a/common/dmthin
+++ b/common/dmthin
@@ -91,6 +91,8 @@ _dmthin_init()
 	if [ -z "$low_water" ]; then
 		low_water=204800	# 100M, in sectors
 	fi
+	# low_water is expressed in blocks of size $cluster_size
+	low_water=$((low_water / cluster_size))
 
 	# Need to make linear metadata and data devs.  From kernel docs:
 	# As a guide, we suggest you calculate the number of bytes to use in the
-- 
2.5.5

