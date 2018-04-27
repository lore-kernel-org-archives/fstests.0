Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52571 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758998AbeD0Q6c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Apr 2018 12:58:32 -0400
Date: Fri, 27 Apr 2018 09:58:30 -0700
From: Andres Freund <andres@anarazel.de>
Subject: Re: [PATCH] generic: test for seeing unseen fsync errors on newly
 open files
Message-ID: <20180427165830.xekrvdv2my6nxjsr@alap3.anarazel.de>
References: <20180427163833.21882-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427163833.21882-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, eguan@redhat.com, willy@infradead.org, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

Hi,

On 2018-04-27 12:38:33 -0400, Jeff Layton wrote:
> This is motivated by some rather odd behavior done by the PostgreSQL
> project. The main database writers will offload the fsync calls to a
> separate process, which can open files after a writeback error has
> already occurred.

;)


> +	ret = pwrite(fd1, buf, bufsize, 0);
> +	if (ret < 0) {
> +		printf("Second write on fd1 failed: %m\n");
> +		return 1;
> +	}
> +
> +	/* Ensure writeback occurs, but don't scrape the error */
> +	sync();

It might be a good idea to also add a second version of this that
additionally evicts inodes after the sync? I think that should be
simulatable with "echo 2 > /proc/sys/vm/drop_caches" or such? That'd
obviously fail for now...

Thanks for the test,

Andres Freund
