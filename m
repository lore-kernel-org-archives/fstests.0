Received: from mx1.redhat.com ([209.132.183.28]:44949 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbbLUNVZ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 21 Dec 2015 08:21:25 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 722C2693E1
	for <fstests@vger.kernel.org>; Mon, 21 Dec 2015 13:21:25 +0000 (UTC)
Received: from localhost (dhcp-12-106.nay.redhat.com [10.66.12.106])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tBLDLM59010359
	for <fstests@vger.kernel.org>; Mon, 21 Dec 2015 08:21:24 -0500
Date: Mon, 21 Dec 2015 21:21:20 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/263: be quiet about unsupported operation
Message-ID: <20151221132120.GW2535@eguan.usersys.redhat.com>
References: <1450703097-3162-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450703097-3162-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 21, 2015 at 09:04:57PM +0800, Eryu Guan wrote:
> Old kernels don't support zero-range/collapse-range/insert-range
> fallocate operations and fail the test as:
> 
>   +fsx: main: filesystem does not support fallocate mode 0x10, disabling!
>   +: Operation not supported
>   +fsx: main: filesystem does not support fallocate mode 0x8, disabling!
>   +: Operation not supported
>   +fsx: main: filesystem does not support fallocate mode 0x20, disabling!
>   +: Operation not supported
> 
> Adding "-q" option to fsx to quiet the warning message.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Please ignore this patch, the "unsupported operation messages" can only
be seen when there're real problems. Sorry for the noise..

Eryu
