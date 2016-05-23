Received: from mx1.redhat.com ([209.132.183.28]:33569 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbcEWJtc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 23 May 2016 05:49:32 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6876081109
	for <fstests@vger.kernel.org>; Mon, 23 May 2016 09:49:31 +0000 (UTC)
Date: Mon, 23 May 2016 17:49:29 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] filter stripe width details from repair
Message-ID: <20160523094929.GB5051@zlang.usersys.redhat.com>
References: <0f397d04-157b-4a56-0100-c12628322477@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f397d04-157b-4a56-0100-c12628322477@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, May 19, 2016 at 04:19:51PM -0500, Eric Sandeen wrote:
> Several golden outputs have:
> 
> > Note - stripe unit (0) and width (0) fields have been reset.
> 
> but it's entirely possible for this to be non-zero,
> which then fails to match and fails the test.
> 
> Filter this repair output and fix the golden files.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/common/repair b/common/repair
> index 537d943..2b1583b 100644
> --- a/common/repair
> +++ b/common/repair
> @@ -89,6 +89,8 @@ s/(inode chunk) (\d+)\/(\d+)/AGNO\/INO/;
>  # sunit/swidth reset messages
>  s/^(Note - .*) were copied.*/\1 fields have been reset./;
>  s/^(Please) reset (with .*) if necessary/\1 set \2/;
> +# And make them generic so we dont depend on geometry
> +s/(stripe unit) \(.*\) (and width) \(.*\)/\1 (SU) \2 (SW)/;
>  # corrupt sb messages
>  s/(superblock) (\d+)/\1 AGNO/;
>  s/(AG \#)(\d+)/\1AGNO/;
> diff --git a/tests/xfs/030.out.linux b/tests/xfs/030.out.linux
> index cf3259f..514ba30 100644
> --- a/tests/xfs/030.out.linux
> +++ b/tests/xfs/030.out.linux
> @@ -39,7 +39,7 @@ Phase 6 - check inode connectivity...
>          - traversal finished ...
>          - moving disconnected inodes to lost+found ...
>  Phase 7 - verify and correct link counts...
> -Note - stripe unit (0) and width (0) fields have been reset.
> +Note - stripe unit (SU) and width (SW) fields have been reset.
>  Please set with mount -o sunit=<value>,swidth=<value>
>  done
>  Corrupting agf 0 - setting bits to 0
> @@ -156,7 +156,7 @@ Phase 6 - check inode connectivity...
>          - traversal finished ...
>          - moving disconnected inodes to lost+found ...
>  Phase 7 - verify and correct link counts...
> -Note - stripe unit (0) and width (0) fields have been reset.
> +Note - stripe unit (SU) and width (SW) fields have been reset.
>  Please set with mount -o sunit=<value>,swidth=<value>
>  done
>  Corrupting agf 0 - setting bits to -1
> diff --git a/tests/xfs/148.out b/tests/xfs/148.out
> index 466a55d..c8fb551 100644
> --- a/tests/xfs/148.out
> +++ b/tests/xfs/148.out
> @@ -43,7 +43,7 @@ Phase 6 - check inode connectivity...
>          - traversals finished ... 
>          - moving disconnected inodes to lost+found ... 
>  Phase 7 - verify and correct link counts...
> -Note - stripe unit (0) and width (0) fields have been reset.
> +Note - stripe unit (SU) and width (SW) fields have been reset.
>  Please set with mount -o sunit=<value>,swidth=<value>
>  done
>  Corrupting agf 0 - setting bits to 0
> @@ -186,7 +186,7 @@ Phase 6 - check inode connectivity...
>          - traversals finished ... 
>          - moving disconnected inodes to lost+found ... 
>  Phase 7 - verify and correct link counts...
> -Note - stripe unit (0) and width (0) fields have been reset.
> +Note - stripe unit (SU) and width (SW) fields have been reset.
>  Please set with mount -o sunit=<value>,swidth=<value>
>  done
>  Corrupting agf 0 - setting bits to -1
> diff --git a/tests/xfs/178.out b/tests/xfs/178.out
> index 1709863..8e0fc8e 100644
> --- a/tests/xfs/178.out
> +++ b/tests/xfs/178.out
> @@ -37,7 +37,7 @@ Phase 6 - check inode connectivity...
>          - traversal finished ...
>          - moving disconnected inodes to lost+found ...
>  Phase 7 - verify and correct link counts...
> -Note - stripe unit (0) and width (0) fields have been reset.
> +Note - stripe unit (SU) and width (SW) fields have been reset.
>  Please set with mount -o sunit=<value>,swidth=<value>
>  done
>  repair passed
> @@ -73,7 +73,7 @@ Phase 6 - check inode connectivity...
>          - traversal finished ...
>          - moving disconnected inodes to lost+found ...
>  Phase 7 - verify and correct link counts...
> -Note - stripe unit (0) and width (0) fields have been reset.
> +Note - stripe unit (SU) and width (SW) fields have been reset.
>  Please set with mount -o sunit=<value>,swidth=<value>
>  done
>  repair passed

Hi,

Finally, this problem be fixed:)

This problem in my TODO list for long time, always no time to do
that(because it doesn't impact many test machines). This
patch looks good, but still more others problems cause by
mutil-strip device. Likes:

1. mkfs warning:
+Warning: AG size is a multiple of stripe width.  This can cause performance
+problems by aligning all AGs on the same disk.  To avoid this, run mkfs with
+an AG size that is one stripe unit smaller, for example 1966016.

2. some cases depand on some certain sunit.

Are you planning to fix them all? Or only this one?

Thanks,
Zorro

> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
