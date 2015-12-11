Received: from mx1.redhat.com ([209.132.183.28]:33201 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbbLKJZJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 11 Dec 2015 04:25:09 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 200A13017A8
	for <fstests@vger.kernel.org>; Fri, 11 Dec 2015 09:25:09 +0000 (UTC)
Date: Fri, 11 Dec 2015 17:25:01 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/293: tighten up checks for documented xfs_io commands
Message-ID: <20151211092501.GT2535@eguan.usersys.redhat.com>
References: <56620316.4090104@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56620316.4090104@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 04, 2015 at 03:18:14PM -0600, Eric Sandeen wrote:
> Some commands (like "zero") are simple words which commonly
> occur in the manpage text even if they aren't documented as
> commands.
> 
> Grep for "   $COMMAND" instead of the bare word, because
> the documented commands show up as indented.
> 
> This reveals that the "zero" command is not documented yet.
> (It catches "help" too, because it's documented differently;
> I'll fix that up in the manpage when I add "zero").
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
> 
> diff --git a/tests/xfs/293 b/tests/xfs/293
> index d1a2853..ade6015 100755
> --- a/tests/xfs/293
> +++ b/tests/xfs/293
> @@ -49,7 +49,7 @@ _supported_os IRIX Linux
>  echo "Silence is golden"
>  
>  for COMMAND in `$XFS_IO_PROG -c help | awk '{print $1}' | grep -v "^Use"`; do
> -  man xfs_io | col -b | grep -wq $COMMAND || \
> +  man xfs_io | col -b | grep -wq "   $COMMAND" || \
>  	echo "$COMMAND not documented in the xfs_io manpage"
>  done
>  
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
