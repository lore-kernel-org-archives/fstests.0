Return-Path: <fstests-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59076 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaH1RSD (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 28 Aug 2014 13:18:03 -0400
Date: Thu, 28 Aug 2014 10:18:02 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/3] common: add cifs support
Message-ID: <20140828171802.GB20891@infradead.org>
References: <1409084918-17764-1-git-send-email-pshilovsky@samba.org>
 <1409084918-17764-3-git-send-email-pshilovsky@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1409084918-17764-3-git-send-email-pshilovsky@samba.org>
Sender: fstests-owner@vger.kernel.org
To: Pavel Shilovsky <pshilovsky@samba.org>
Cc: fstests@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@samba.org, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 27, 2014 at 12:28:37AM +0400, Pavel Shilovsky wrote:
> +    - You can explicitly specify NFS or CIFS, otherwise the filesystem type will
> +      be autodetected from $TEST_DEV:
>        ./check -nfs [test(s)]

Can you take care of mentioning tmpfs as well, looks like it didn't get
added here when support was added.

>  	;;
> +    cifs)
> +	# Don't know how to check a CIFS filesystem, yet.
> +	;;

Will we ever find a way to sanity check a cifs fs? :)

Otherwise looks fine to me.
