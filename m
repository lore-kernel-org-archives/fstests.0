Received: from bombadil.infradead.org ([198.137.202.9]:45007 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbcBQKGE (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Feb 2016 05:06:04 -0500
Date: Wed, 17 Feb 2016 02:06:03 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 12/16] xfstests: remove dependency on /proc/partitions
 for generic/312
Message-ID: <20160217100603.GK21482@infradead.org>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
 <1455385269-26319-13-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455385269-26319-13-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

> +# We don't need to do this check for tmpfs because _scratch_mkfs_size
> +# will validate the size against the available memory
> +if [ "$FSTYP" != "tmpfs" ]; then
> +   _scratch_mkfs
> +   _scratch_mount
> +   _require_fs_space $SCRATCH_MNT $(($fssize / 1024))
> +   _scratch_unmount
> +fi
>  rm -f $seqres.full
>  _scratch_mkfs_sized $fssize >>$seqres.full 2>&1

_scratch_mkfs_size also validates the available space for other
block based file systems, so I think we should just remove this
code entirely (assuming I didn't miss something important)
