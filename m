Received: from mx144.netapp.com ([216.240.21.25]:65262 "EHLO mx144.netapp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753793AbbLCUng (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 3 Dec 2015 15:43:36 -0500
Subject: Re: sys_copy_file_range tests
References: <20151201181011.GA6202@infradead.org>
From: Anna Schumaker <Anna.Schumaker@netapp.com>
Message-ID: <5660A974.3010200@Netapp.com>
Date: Thu, 3 Dec 2015 15:43:32 -0500
MIME-Version: 1.0
In-Reply-To: <20151201181011.GA6202@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Christoph,

On 12/01/2015 01:10 PM, Christoph Hellwig wrote:
> Hi Anna,
> 
> I recently looked into allowing sys_copy_file_range to use the
> clone_file_range operation so that file systems don't have to support
> two methods if they only support clone-like features, and one thing
> I noticed is that unlike for clone there are no tests for
> clone_file_range in xfstests, and I couldn't find a testsuite anywhere
> else either.  Do you have any good tests available to verify the
> implementation?
> 

Sadly, I don't have very good tests and I was mostly using the example program from the man page under various filesystems and setups.  At LPC, Darrick made it sound like he was going to work on adding vfs_copy_file_range() tests to xfstests but that probably turned into the reflink/dedupe ioctl tests.

I can try to find time to write something for xfstests if that would be useful!

Anna

