Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39204 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbcDVKY4 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 22 Apr 2016 06:24:56 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5190F62654
	for <fstests@vger.kernel.org>; Fri, 22 Apr 2016 10:24:55 +0000 (UTC)
Date: Fri, 22 Apr 2016 18:24:53 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] overlay: notrun if upper fs does not support d_type
Message-ID: <20160422102453.GJ4675@eguan.usersys.redhat.com>
References: <1461312715-14197-2-git-send-email-xzhou@redhat.com>
 <1461316911-17533-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461316911-17533-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 22, 2016 at 05:21:51PM +0800, Xiong Zhou wrote:
> Overlayfs whiteout can be visible if underlying upper fs does not
> support d_type. Kernel commit
> 	45aebea (ovl: Ensure upper filesystem supports d_type)
> prevents mounting overlayfs like this since v4.6-rc1.
> 
> Check upper fs before mounting overlay, mark as not run if needs.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>

I'm not sure if this really necessary, but looks fine to me.

Reviewed-by: Eryu Guan <eguan@redhat.com>
