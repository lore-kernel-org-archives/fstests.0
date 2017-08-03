Received: from mx1.redhat.com ([209.132.183.28]:34304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751084AbdHCMKi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 3 Aug 2017 08:10:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 810C3C04B958
        for <fstests@vger.kernel.org>; Thu,  3 Aug 2017 12:10:38 +0000 (UTC)
Date: Thu, 3 Aug 2017 08:10:37 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] fstests: batch update of test file mode
Message-ID: <20170803121036.GG62447@bfoster.bfoster>
References: <20170803055304.20928-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170803055304.20928-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 03, 2017 at 01:53:04PM +0800, Eryu Guan wrote:
> Some tests don't have x permission set in mode, git complains about
> file mode change after running tests in fstests git repo dir. So
> change all such tests to 755 mode. Performed by:
> 
> find tests ! -perm /111 -name [0-9][0-9][0-9] -exec chmod 755 {} \;
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> 
> We've done this several times before, now I've written a local
> post-applypatch hook that will detect & change the wrong test file
> permissions and prompt to do 'git commit --amend'. Hope that this is the
> last commit to do such changes..
> 

Reviewed-by: Brian Foster <bfoster@redhat.com>

> Eryu
> 
>  tests/generic/340 | 0
>  tests/generic/341 | 0
>  tests/generic/342 | 0
>  tests/generic/344 | 0
>  tests/generic/345 | 0
>  tests/generic/346 | 0
>  tests/generic/354 | 0
>  tests/generic/408 | 0
>  8 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 tests/generic/340
>  mode change 100644 => 100755 tests/generic/341
>  mode change 100644 => 100755 tests/generic/342
>  mode change 100644 => 100755 tests/generic/344
>  mode change 100644 => 100755 tests/generic/345
>  mode change 100644 => 100755 tests/generic/346
>  mode change 100644 => 100755 tests/generic/354
>  mode change 100644 => 100755 tests/generic/408
> 
> diff --git a/tests/generic/340 b/tests/generic/340
> old mode 100644
> new mode 100755
> diff --git a/tests/generic/341 b/tests/generic/341
> old mode 100644
> new mode 100755
> diff --git a/tests/generic/342 b/tests/generic/342
> old mode 100644
> new mode 100755
> diff --git a/tests/generic/344 b/tests/generic/344
> old mode 100644
> new mode 100755
> diff --git a/tests/generic/345 b/tests/generic/345
> old mode 100644
> new mode 100755
> diff --git a/tests/generic/346 b/tests/generic/346
> old mode 100644
> new mode 100755
> diff --git a/tests/generic/354 b/tests/generic/354
> old mode 100644
> new mode 100755
> diff --git a/tests/generic/408 b/tests/generic/408
> old mode 100644
> new mode 100755
> -- 
> 2.13.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
