Received: from mx1.redhat.com ([209.132.183.28]:52108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751795AbdIVHit (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 22 Sep 2017 03:38:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B5E961462
        for <fstests@vger.kernel.org>; Fri, 22 Sep 2017 07:38:49 +0000 (UTC)
Date: Fri, 22 Sep 2017 15:38:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic: test mount move semantics
Message-ID: <20170922073847.GC8034@eguan.usersys.redhat.com>
References: <20170921082423.22710-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921082423.22710-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 21, 2017 at 04:24:23PM +0800, Zorro Lang wrote:
> This's a functional test case for mount --move operation, it verifies
> below semantics:
> 
>   ---------------------------------------------------------------------------
>   |         MOVE MOUNT OPERATION                                            |
>   |**************************************************************************
>   |source(A)->| shared       |       private  |       slave    | unbindable |
>   | dest(B)  |               |                |                |            |
>   |   |      |               |                |                |            |
>   |   v      |               |                |                |            |
>   |**************************************************************************
>   |  shared  | shared        |     shared     | shared & slave |  invalid   |
>   |          |               |                |                |            |
>   |non-shared| shared        |      private   |      slave     | unbindable |
>   ***************************************************************************
>   NOTE: moving a mount residing under a shared mount is invalid.
> 
> This case uses fsstress to produce a little random load, to make
> sure basic operations won't break the the moved mountpoints.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Thanks for the test! As what we discussed just now, the --move semantics
test is hard to follow, please add more comments inline to describe your
test steps and purpose.

Thanks,
Eryu
