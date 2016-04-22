Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36316 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbcDVKJ0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 22 Apr 2016 06:09:26 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2CEF62654
	for <fstests@vger.kernel.org>; Fri, 22 Apr 2016 10:09:25 +0000 (UTC)
Date: Fri, 22 Apr 2016 18:09:24 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] overlay: test basic whiteout
Message-ID: <20160422100924.GI4675@eguan.usersys.redhat.com>
References: <20160421125732.GF4675@eguan.usersys.redhat.com>
 <1461312715-14197-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461312715-14197-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 22, 2016 at 04:11:54PM +0800, Xiong Zhou wrote:
> Once a while, overlayfs whiteout can be visible if upper fs
> does not support d_type(ftype/filetype). Test as a sanity
> check on whiteout of regular files, links, dirs, devices
> and pipes.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>

Looks good to me, thanks!

Reviewed-by: Eryu Guan <eguan@redhat.com>
