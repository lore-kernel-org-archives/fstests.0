Received: from mail-yw0-f174.google.com ([209.85.161.174]:34068 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967255AbeBNLWI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Feb 2018 06:22:08 -0500
Received: by mail-yw0-f174.google.com with SMTP id z77so2815062ywa.1
        for <fstests@vger.kernel.org>; Wed, 14 Feb 2018 03:22:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180214110331.ojgyabcta34lzo4s@quack2.suse.cz>
References: <20180212053822.whuqpncgddzm3l6n@XZHOUW.usersys.redhat.com>
 <1518414408-23149-1-git-send-email-xzhou@redhat.com> <20180214110331.ojgyabcta34lzo4s@quack2.suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Feb 2018 13:22:06 +0200
Message-ID: <CAOQ4uxhUv0Wy+v_i8mzhx5y7NA88VyULxWniJ-HXCLg_Pq7bUw@mail.gmail.com>
Subject: Re: [PATCH v4] generic: add stress test for fanotify and inotify
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 14, 2018 at 1:03 PM, Jan Kara <jack@suse.cz> wrote:
> On Mon 12-02-18 13:46:48, Xiong Zhou wrote:
>> Stress test for fanotify and inotify. Exercise fanotify and
>> inotify user interfaces in loop while other stress tests going
>> on in the watched test directory.
>>
>> Watching slab object inotify_inode_mark size, report fail
>> it increases too fast. This may lead to a crash if OOM killer
>> invoked.
>>
>> kernel commit related to the fixes in v4.15-rc1:
>> 0d6ec07 fsnotify: pin both inode and vfsmount mark
>>
>> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
>
> I'm sorry for chiming in so late but I was on vacation. Just one question:
> Currently, all inotify and fanotify tests are part of LTP. Is there any
> good reason for putting this particular test to fstests and not LTP?
> Specifically I've refrained from putting notification framework tests to
> fstests because there's practically no relation of it to implementation of
> any particular filesystem. Also I'd prefer not to have fanotify / inotify
> tests in two different frameworks...
>

I second that.
Also, Eryu did not chime in yet (and Dave probably did not look closely),
but I think fstests in general try to refrain from single purpose test
programs such as fsnotify_stress.

Xiong,

If you do choose to implement an LTP test as Jan recommended,
please base it on top of my patches to convert LTP inotify tests to
new lib https://github.com/linux-test-project/ltp/pull/246.

Thanks,
Amir.
