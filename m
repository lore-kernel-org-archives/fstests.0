Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:34233 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbbCKOwI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Mar 2015 10:52:08 -0400
Message-ID: <55005696.2080106@sandeen.net>
Date: Wed, 11 Mar 2015 10:52:06 -0400
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] common: append -d option to XFS_COPY_PROG when testing
 v5 xfs
References: <1426072534-12246-1-git-send-email-eguan@redhat.com> <1426072534-12246-4-git-send-email-eguan@redhat.com> <550055B2.3040308@sandeen.net>
In-Reply-To: <550055B2.3040308@sandeen.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 3/11/15 10:48 AM, Eric Sandeen wrote:
> On 3/11/15 7:15 AM, Eryu Guan wrote:
>> xfs_copy doesn't work on v5 xfs without -d option, this fails xfs/073
>> when testing xfs with MKFS_OPTIONS="-m crc=1" set.
> 
> Neat, I did not know about the "=~" trick ;)
> 
> Test xfs/073 adds -d already, but two -d's are accepted...
> 
> ... but the xfs/073 fails due to the fallback to nouuid, forced by
> the duplicate ID which is found:
> 
> @@ -17,6 +17,7 @@
>  All copies completed.
>  checking new image
>  mounting new image on loopback
> +retrying mount with nouuid option

Oh, patch 4 fixes this.

Dave, you might want to apply 3 & 4 in swapped order.

I think this is ok for now,

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

