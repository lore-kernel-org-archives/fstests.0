Received: from szxga05-in.huawei.com ([45.249.212.191]:4259 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755220AbeASBaU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Jan 2018 20:30:20 -0500
Subject: Re: [PATCH v4 4/5] fsck.overlay: add merge and redirect subdir count
References: <20180118035056.17358-1-yi.zhang@huawei.com>
 <20180118035056.17358-5-yi.zhang@huawei.com>
 <CAOQ4uxjcFGAGC-CRpQ8Stu1daXtHi8vkn701YSPNymVe2qfOUw@mail.gmail.com>
From: "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <ed9b1dab-2287-d22b-493b-41066ea385a2@huawei.com>
Date: Fri, 19 Jan 2018 09:29:24 +0800
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjcFGAGC-CRpQ8Stu1daXtHi8vkn701YSPNymVe2qfOUw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: overlayfs <linux-unionfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Eryu Guan <eguan@redhat.com>, Miao Xie <miaoxie@huawei.com>, yangerkun@huawei.com, "zhangyi (F)" <yizhang089@gmail.com>
List-ID: <fstests@vger.kernel.org>

On 2018/1/18 15:13, Amir Goldstein Wrote:
> On Thu, Jan 18, 2018 at 5:50 AM, zhangyi (F) <yi.zhang@huawei.com> wrote:
>> +/* Count merge dir and redirect dir in a specified directory */
>> +static int ovl_count_unreal(struct scan_ctx *sctx)
> 
> I am amused by this name :)
> FYI, the legacy term used for a directory that is NOT a merge directory
> is "pure", such as "pure upper" or "pure lower".
> 
> Confusingly, the "impure dir" term is not exactly the opposite
> of the legacy "pure dir" term, but really is a shortcut for
> "dir that contains non pure entries".
> We could have called the xattr "impurities", but we (I) didn't.
> 
> So, basically, merge and redirect dir are "impurities",
> which make the parent dir "impure".
> 
> See for example:
> void ovl_dentry_version_inc(struct dentry *dentry, bool impurity)
> 
> 'impurity' refers to merge/redirect children of parent,
> kind of like this scan function, so I propose either:
> ovl_count_impurities()
> OR
> ovl_count_impure()
> 
Ha, I've thouht it for a long time, but still cannot find a proper word.
Because I think 'impure' may confuse with the meaning of directory with
impure xattr. Now, the 'impurities' looks great, thanks! :)

> I realize that there is overlap in the term with ovl_count_origin(),
> which also counts impurities, but still..

Right, origin target is also a kind of impurities, I will improve this.

Thanks,
Yi.

