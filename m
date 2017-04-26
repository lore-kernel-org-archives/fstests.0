Received: from mga09.intel.com ([134.134.136.24]:26539 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932610AbdDZSAX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Apr 2017 14:00:23 -0400
Date: Wed, 26 Apr 2017 12:00:21 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v2 2/2] dax: add regression test for stale mmap reads
Message-ID: <20170426180021.GB15921@linux.intel.com>
References: <20170425205106.20576-1-ross.zwisler@linux.intel.com>
 <20170425205106.20576-2-ross.zwisler@linux.intel.com>
 <20170426090907.q5jj3ywsvldsbq7n@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426090907.q5jj3ywsvldsbq7n@XZHOUW.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, fstests@vger.kernel.org, jmoyer@redhat.com, eguan@redhat.com, Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@ml01.01.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 26, 2017 at 05:09:07PM +0800, Xiong Zhou wrote:
> On Tue, Apr 25, 2017 at 02:51:06PM -0600, Ross Zwisler wrote:
<>
> > +	/*
> > +	 * Try and use the mmap to read back the data we just wrote with
> > +	 * pwrite().  If the kernel bug is present the mapping from the 2MiB
> > +	 * zero page will still be intact, and we'll read back zeros instead.
> > +	 */
> > +	if (strncmp(buffer, data, strlen(buffer))) {
> > +		fprintf(stderr, "strncmp mismatch: '%s' vs '%s'\n", buffer,
> > +				data);
> 		munmap
> 		close(fd);
> > +		exit(1);
> > +	}
> > +
> 	munmap

Yep, thanks, fixed in v3.
