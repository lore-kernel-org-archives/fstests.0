Received: from mail-yw0-f180.google.com ([209.85.161.180]:44396 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdLDIoU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Dec 2017 03:44:20 -0500
Received: by mail-yw0-f180.google.com with SMTP id m129so6356412ywb.11
        for <fstests@vger.kernel.org>; Mon, 04 Dec 2017 00:44:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <226EEED1-8707-485D-BEE8-45DBB4D4F670@mykernel.net>
References: <1512100554-16368-1-git-send-email-cgxu@mykernel.net>
 <621FF37E-8612-489C-8721-4BBC08BAB336@mykernel.net> <20171201041301.GB2749@eguan.usersys.redhat.com>
 <DF0589AC-18BE-495E-8DFD-54F0690CC8E7@mykernel.net> <CAOQ4uxgOyPy9w96_HaUtM1thHcajn1LuHkiFSOtMZw0f-=HR8g@mail.gmail.com>
 <20171201214320.GU4094@dastard> <CAOQ4uxg5RfRXATfcBK3CRouioEDwu_RpqxPLry2fyp8Qq0RdjQ@mail.gmail.com>
 <20171202214030.GW4094@dastard> <CAOQ4uxj4kBygrqA44OPCoJ4qRFFF_hPSeY8DL=Y8DA_eTa=p4Q@mail.gmail.com>
 <226EEED1-8707-485D-BEE8-45DBB4D4F670@mykernel.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 Dec 2017 10:44:18 +0200
Message-ID: <CAOQ4uxhDuLes4nN59Um=TMtaKvcRoP0LkTnmg-FfafQWk+3_qw@mail.gmail.com>
Subject: Re: [PATCH] common: Add infrastructure for syncfs syscall tests
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Chengguang Xu <cgxu@mykernel.net>
Cc: Dave Chinner <david@fromorbit.com>, Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 4, 2017 at 8:05 AM, Chengguang Xu <cgxu@mykernel.net> wrote:
>
...
>> All right.
>> We don't need to implement FS_IOC_SHUTDOWN on overlay, we
>> only need to shutdown upper fs if upper fs supports shutdown.
>> Doing that would be the equivalent of a dm-flakey test for a blokdev fs,
>> because upper fs is the only persistent storage of overlayfs.
>> Thanks for the advice.
>>
>> Chengguang,
>>
>> I propose that you teach _require_scratch_shutdown about
>> OVL_BASE_SCRATCH_MNT and write and overlay/* test
>> that tests syncfs by shutting down upper fs if upper fs supports shutdow=
n.
>
> OK, let me try this way, for data correctness I=E2=80=99ll use stat & md5=
_checksum.
> Is there anything else should I add for checking?
>

Sounds good to me.

Amir.
