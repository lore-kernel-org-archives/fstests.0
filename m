Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:62633 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751594AbcFVAIc (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2016 20:08:32 -0400
Date: Wed, 22 Jun 2016 10:03:52 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] dmthin: express low_water in cluster_size not sector size
Message-ID: <20160622000352.GG27480@dastard>
References: <1466398386-5248-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466398386-5248-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 20, 2016 at 12:53:06PM +0800, Eryu Guan wrote:
> I noticed that thin-pool sent out "reached low water mark for data
> device" event even before thin-pool device was mounted in
> generic/347, this is because low water mark was set to a too high
> value.
> 
> According to kernel thin-provisioning.txt documentation, low water
> mark should be expressed in blocks of $cluster_size, not in sectors.
> 
> "$low_water_mark is expressed in blocks of size $data_block_size."
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
