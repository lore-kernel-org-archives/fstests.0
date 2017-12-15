Received: from mail-qt0-f177.google.com ([209.85.216.177]:43118 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932616AbdLOQRI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 15 Dec 2017 11:17:08 -0500
Received: by mail-qt0-f177.google.com with SMTP id w10so12649773qtb.10
        for <fstests@vger.kernel.org>; Fri, 15 Dec 2017 08:17:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215151644.GA6427@redhat.com>
References: <20171214064747.20999-2-yi.zhang@huawei.com> <CAJfpegvCDyD3Zmc-h5hzkYRGC-cAn4myub3fwvqEVhRNse=yaw@mail.gmail.com>
 <CAOQ4uxh-4kKPLHDXHJux2_tM35frxxNWmPEZcDu2EQ2n+yYkKA@mail.gmail.com>
 <CAJfpegt7LR=G+UK5VY0kEScduuBj2SFhAw3pf1_8NSM+r61PeQ@mail.gmail.com>
 <CAOQ4uxg7UahQ=t2sWpf0FEi7MP+OT3XfO8AB_y+0qpeq8CWgrA@mail.gmail.com>
 <CAJfpegt-Upt3z4wFVQJ5bJf9pBbjOGXd93P+3LZdemSeS0Y_BA@mail.gmail.com>
 <CAOQ4uxg+DY=9MT+2sPNBnM77qv8eqyY5mCqnE6k1viptmLR8yA@mail.gmail.com>
 <CAJfpegsMT6ctTDRDQHosz52ZTg5gQgmxr5Em3YGm-htQzdNjCA@mail.gmail.com>
 <CAOQ4uxhU72XkzeTr19p5G+nGt9ONfb8=AxzqOBk-Sc2seR2fLw@mail.gmail.com>
 <CAJfpegsQvKfOLh2cWj496+g9pFFPmXbRdwZobqVDaQ_7-EBgrQ@mail.gmail.com> <20171215151644.GA6427@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 15 Dec 2017 17:17:06 +0100
Message-ID: <CAJfpegu3wdY7EQ-ukDi3=F-qyiFnoh4yAHVz7injud0q0XhxuQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] overlay: implement fsck utility
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, "zhangyi (F)" <yi.zhang@huawei.com>, "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, Miao Xie <miaoxie@huawei.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 15, 2017 at 4:16 PM, Vivek Goyal <vgoyal@redhat.com> wrote:

> So idea is that I should use use REDIRECT xattr instead of ORIGIN for
> metacopy. I guess it should work for atleast metacopy feature. Just
> that order of lower dirs during mount will not be detected and IIUC,
> we might end up doing a copy up of wrong file.

Probably should use both.  Need to think about what should happen in
case of an inconsitency.

Thanks,
Miklos
