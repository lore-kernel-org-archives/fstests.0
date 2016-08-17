Received: from mail-it0-f43.google.com ([209.85.214.43]:36488 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbcHQJ1j (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Aug 2016 05:27:39 -0400
Received: by mail-it0-f43.google.com with SMTP id e63so56238596ith.1
        for <fstests@vger.kernel.org>; Wed, 17 Aug 2016 02:27:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160817033640.GP27776@eguan.usersys.redhat.com>
References: <1471403935-24222-1-git-send-email-yangx.jy@cn.fujitsu.com> <20160817033640.GP27776@eguan.usersys.redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Wed, 17 Aug 2016 11:27:18 +0200
Message-ID: <CACj3i71OVqnAwGaKO_x1r+oX-BmmEBncij-wZzqHDKXytq23-g@mail.gmail.com>
Subject: Re: [PATCH] xfs/191: skip tests on older xfsprogs
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 17, 2016 at 5:36 AM, Eryu Guan <eguan@redhat.com> wrote:

>>  _mkfs_validation_check()
>>  {
>> +     if [ ! -f /tmp/foo ]; then
>> +             touch /tmp/foo
>> +     fi
>
> I think the file can be touched unconditionally.
>

If the file already exists and mtime/atime of the file is important,
then it could be an issue. It looks improbable, but still, maybe we
should be on the safe side?

Anyway, thanks for spotting this.

Jan

-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
