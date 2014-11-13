Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:48544 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbaKMEIz (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 12 Nov 2014 23:08:55 -0500
MIME-Version: 1.0
In-Reply-To: <20141113032824.GB28565@dastard>
References: <1415617191-17246-1-git-send-email-eguan@redhat.com>
 <CAH2r5muXH7HSoM0TQUsPXq1RM-dLdZSfzuOKK1zZdKe0OANAhg@mail.gmail.com>
 <20141110160309.GI2863@dhcp-13-216.nay.redhat.com> <CAH2r5mtCPVt7+fyCjvDrLtOSzX1-+YQ_ZPhyU5gjFP7c1DJFKw@mail.gmail.com>
 <20141113032824.GB28565@dastard>
From: Steve French <smfrench@gmail.com>
Date: Wed, 12 Nov 2014 22:08:34 -0600
Message-ID: <CAH2r5mtEq0gyNn+8+_UzDc0KRskHnnzDHipa=hqeFOf8y1jH1A@mail.gmail.com>
Subject: Re: [PATCH] common: enable tests that require scratch device on CIFS
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 12, 2014 at 9:28 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Nov 12, 2014 at 05:26:13PM -0600, Steve French wrote:
>> I get newly enabled test 294 passing on cifs mounts to Samba.
>>
>> What is best way to get the mount options passed to the mount of
>> scratch dev so it doesn't prompt for it?
>
> # MOUNT_OPTIONS="-o ...." ./check -g auto

much better - that worked - thanks

I had been using TEST_FS_MOUNT_OPTS (so I could have multiple sections
in local.config) rather
than MOUNT_OPTIONS


-- 
Thanks,

Steve
