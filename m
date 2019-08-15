Received: from mail.kernel.org ([198.145.29.99]:48346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730336AbfHOV0E (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 15 Aug 2019 17:26:04 -0400
Date: Thu, 15 Aug 2019 14:26:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 3/2] fstests: check that we can't write to swap
 files
Message-Id: <20190815142603.de9f1c0d9fcc017f3237708d@linux-foundation.org>
In-Reply-To: <20190815163434.GA15186@magnolia>
References: <156588514105.111054.13645634739408399209.stgit@magnolia>
        <20190815163434.GA15186@magnolia>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: hch@infradead.org, tytso@mit.edu, viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, 15 Aug 2019 09:34:34 -0700 "Darrick J. Wong" <darrick.wong@oracle.com> wrote:

> While active, the media backing a swap file is leased to the kernel.
> Userspace has no business writing to it.  Make sure we can't do this.

I don't think this tests the case where a file was already open for
writing and someone does swapon(that file)?

And then does swapoff(that file), when writes should start working again?

Ditto all the above, with s/open/mmap/.


Do we handle (and test!) the case where there's unwritten dirty
pagecache at the time of swapon()?  Ditto pte-dirty MAP_SHARED pages?
