Received: from mail-yw0-f195.google.com ([209.85.161.195]:37774 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdKWIFB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Nov 2017 03:05:01 -0500
Received: by mail-yw0-f195.google.com with SMTP id x20so8176723ywg.4
        for <fstests@vger.kernel.org>; Thu, 23 Nov 2017 00:05:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171123070804.GT2749@eguan.usersys.redhat.com>
References: <20171118061906.11227-1-eguan@redhat.com> <20171123070804.GT2749@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Nov 2017 10:05:00 +0200
Message-ID: <CAOQ4uxhoD=zgXJ9UC2+6+jCL6u+3_sxPanRb4xJ9M2SZSrPysQ@mail.gmail.com>
Subject: Re: [PATCH] ltp/fsx: really skip fallocate keep_size calls when
 replaying ops
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 23, 2017 at 9:08 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Sat, Nov 18, 2017 at 02:19:06PM +0800, Eryu Guan wrote:
>> On start up, fsx checks for various fallocate(2) operation support
>> status and disables unsupported operations. But when replaying
>> operations from a log, fsx failed to skip KEEP_SIZE fallocate(2)
>> calls if underlying filesystem doesn't support it. For example,
>> NFSv4.2 supports fallocate(2) but not KEEP_SIZE, and this causes
>> generic/469 fails on NFSv4.2.
>>
>> Fix it by taking 'keep_size_calls' into consideration when replaying
>> ops from log file.
>>
>> Signed-off-by: Eryu Guan <eguan@redhat.com>
>> ---
>>
>> Note that generic/469 hasn't been pushed to upstream yet. Will do in
>> this week's update.
>
> generic/469 is upstream now, still need some reviews on this patch.
>

I don't like the path we have taken starting with generic/456 (so partly
my own blame) that the test passes instead of "not run" for fs that
don't support the replayed fsx operations, because fsx skips them.

Because the sub-test in question really wants to test KEEP_SIZE,
IMO we should explicitly:

_require_xfs_io_command "falloc" "-k"
_require_xfs_io_command "fpunch"

And for generic/456, we should also explicitly:

_require_xfs_io_command "fpunch"
_require_xfs_io_command "fzero"
_require_xfs_io_command "fcollapse"

Amir.
