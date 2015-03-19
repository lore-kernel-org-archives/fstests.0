Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36548 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbbCSQCV (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 19 Mar 2015 12:02:21 -0400
Received: by wibg7 with SMTP id g7so121962425wib.1
        for <fstests@vger.kernel.org>; Thu, 19 Mar 2015 09:02:20 -0700 (PDT)
Message-ID: <550AF30A.8040906@plexistor.com>
Date: Thu, 19 Mar 2015 18:02:18 +0200
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3] xfstest: generic/080 test that mmap-write updates
 c/mtime
References: <54F733BD.7060807@plexistor.com> <54F734C4.7080409@plexistor.com> <20150305001312.GA4251@dastard> <550A9C84.4090807@plexistor.com> <20150319104409.GO4810@dhcp-13-216.nay.redhat.com> <550AB720.3090009@plexistor.com> <20150319153037.GQ4810@dhcp-13-216.nay.redhat.com>
In-Reply-To: <20150319153037.GQ4810@dhcp-13-216.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <matthew.r.wilcox@intel.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 03/19/2015 05:30 PM, Eryu Guan wrote:
<>
> 
> I tested it with xfs/ext4/btrfs/nfs and cifs, cifs failed the test.
> 

Ha there you go. I think git has some operation that do this and
the date gets screwed.

> The test looks good to me (with one nitpick below).
> 

I have sent v4 that fixes this

> Reviewed-by: Eryu Guan <eguan@redhat.com>
> 

And also added this one.

Thank you sir Eryu
Boaz

