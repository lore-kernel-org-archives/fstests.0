Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34655 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbbCSLt3 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 19 Mar 2015 07:49:29 -0400
Message-ID: <550AB7C4.8040302@gmail.com>
Date: Thu, 19 Mar 2015 13:49:24 +0200
From: Boaz Harrosh <openosd@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3] xfstest: generic/080 test that mmap-write updates
 c/mtime
References: <54F733BD.7060807@plexistor.com> <54F734C4.7080409@plexistor.com> <20150305001312.GA4251@dastard> <550A9C84.4090807@plexistor.com> <20150319104409.GO4810@dhcp-13-216.nay.redhat.com> <550AB720.3090009@plexistor.com>
In-Reply-To: <550AB720.3090009@plexistor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Boaz Harrosh <boaz@plexistor.com>, Eryu Guan <eguan@redhat.com>, Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <matthew.r.wilcox@intel.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 03/19/2015 01:46 PM, Boaz Harrosh wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> when using mmap() for file i/o, writing to the file should update
> it's c/mtime. Specifically if we first mmap-read from a page, then
> memap-write to the same page.
> 
> This test was failing for the initial submission of DAX because
> pfn based mapping do not have an page_mkwrite called for them.
> The new Kernel patches that introduce pfn_mkwrite fixes this test.
> 
> Written by Dave Chinner but edited and tested by:
> 	Omer Zilberberg
> 
> Dave hands-up man, it looks like you edited this directly
> in the email, but there was not even a single typo.
> 
> Tested-by: Omer Zilberberg <omzg@plexistor.com>
> Tested-by: Boaz Harrosh <boaz@plexistor.com>
> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
> Signed-off-by: Boaz Harrosh <boaz@plexistor.com>
> Need-Reviewed-by: Eryu Guan <eguan@redhat.com>

Hi Eryu

Thank you for your review.

I have tried to incorporate your comments, I hope its what you meant.

Thanks
Boaz

