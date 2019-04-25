Received: from mail-io1-f65.google.com ([209.85.166.65]:44939 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfDYVYH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Apr 2019 17:24:07 -0400
Received: by mail-io1-f65.google.com with SMTP id r71so1226105iod.11
        for <fstests@vger.kernel.org>; Thu, 25 Apr 2019 14:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <1483501871-15389-1-git-send-email-deepa.kernel@gmail.com> <20190425174453.GN20156@twin.jikos.cz>
In-Reply-To: <20190425174453.GN20156@twin.jikos.cz>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Thu, 25 Apr 2019 14:23:55 -0700
Message-ID: <CABeXuvqjwNYL4yctJpywW7Ogjm0=yWU7aVrxC_Pu-ggQT+1-kQ@mail.gmail.com>
Subject: Re: Obsolete test? (Was: Re: [PATCH v3] generic/390: Add tests for
 inode timestamp policy)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: dsterba@suse.cz
Cc: fstests@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>
List-ID: <fstests@vger.kernel.org>

> On Apr 25, 2019, at 10:44 AM, David Sterba <dsterba@suse.cz> wrote:
>
>> On Tue, Jan 03, 2017 at 07:51:11PM -0800, Deepa Dinamani wrote:
>> The test helps to validate clamping and mount behaviors
>> according to supported file system timestamp ranges.
>>
>> Note that the test can fail on 32-bit systems for a
>> few file systems. This will be corrected when vfs is
>> transitioned to use 64-bit timestamps.
>>
>> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>> ---
>> The branch of the kernel tree can be located at
>>
>> https://github.com/deepa-hub/vfs refs/heads/vfs_timestamp_policy
>
> It's 2019 and the functionality hasn't been merged to kernel, but maybe
> there's a replacement I have missed.
>
>> +# timestamp ranges support.
>> +_require_y2038()
>> +{
>> +    local device=3D${1:-$TEST_DEV}
>> +    local sysfsdir=3D/proc/sys/fs/fs-timestamp-check-on
>> +
>> +    if [ ! -e $sysfsdir ]; then
>> +        _notrun "no kernel support for y2038 sysfs switch"
>> +    fi
>
> This will always fail, so either the kernel functionality gets merged or
> the test dropped. Can you let us know the status? Thanks.

I=E2=80=99m posting a more comprehensive kernel series (~35 patches) for th=
is
in a week or so. This test was requested as a prerequisite to merge
the series:
https://lists.linaro.org/pipermail/y2038/2016-November/001981.html
There have been 5 versions of patches posted since then. It has been a
little difficult to get these reviewed.

The series makes more sense now anyway as we finally have 64 bit
timestamps for vfs.
If the test is a precondition, then we should still keep it?

-Deepa

-Deepa
