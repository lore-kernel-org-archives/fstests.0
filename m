Received: from mail.cn.fujitsu.com ([183.91.158.132]:33340 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725929AbfBZCHq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Feb 2019 21:07:46 -0500
Message-ID: <5C749F6A.8070404@cn.fujitsu.com>
Date: Tue, 26 Feb 2019 10:07:38 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] src/t_attr_corruption: use security.capability instead
 of security.evm
References: <20190225191052.15342-1-jeffm@suse.com> <20190225224744.GY6503@magnolia> <20190225232629.GA7159@magnolia>
In-Reply-To: <20190225232629.GA7159@magnolia>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: jeffm@suse.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2019/02/26 7:26, Darrick J. Wong wrote:
> On Mon, Feb 25, 2019 at 02:47:44PM -0800, Darrick J. Wong wrote:
>> On Mon, Feb 25, 2019 at 02:10:52PM -0500, jeffm@suse.com wrote:
>>> From: Jeff Mahoney<jeffm@suse.com>
>>>
>>> src/t_attr_corruption uses the security.evm extended attribute because
>>> it sorts before security.posix_acl_access.  The security.evm attribute
>>> is a formatted structure and when passed an uninitialized buffer, it
>>> will fail with EPERM.
>>>
>>> We see test failures like:
>>>      --- tests/generic/529.out2019-02-21 13:22:47.583406922 -0500
>>>      +++ /opt/xfstests/results//generic/529.out.bad 2019-02-21 13:57:31.967406922 -0500
>>>      @@ -1,2 +1,2 @@
>>>       QA output created by 529
>>>      -list attr: Numerical result out of range
>>>      +set evm: Operation not permitted
>>>
>>> This patch uses security.capability which also sorts where it needs to
>>> do for the test and also accepts an unformatted buffer.
>>>
>>> Signed-off-by: Jeff Mahoney<jeffm@suse.com>
>>> ---
>>>   src/t_attr_corruption.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/src/t_attr_corruption.c b/src/t_attr_corruption.c
>>> index f26611f9..0c229dbc 100644
>>> --- a/src/t_attr_corruption.c
>>> +++ b/src/t_attr_corruption.c
>>> @@ -76,7 +76,7 @@ int main(int argc, char *argv[])
>>>   	if (ret)
>>>   		die("set posix acl");
>>>
>>> -	ret = fsetxattr(fd, "security.evm", buf, 1, 1);
>>> +	ret = fsetxattr(fd, "security.capability", buf, 1, 1);
>> This fails for me both with and without EVM configured into my kernel:
>>
>> fsetxattr(3, "security.capability", "\3", 1, XATTR_CREATE) = -1 EINVAL (Invalid argument)
>>
>> Judging from fs/xattr.c it looks as though security.capability also has
>> a defined format that's parsed by security/commoncap.c...
> And now that I've figured out how to reproduce the xfs bug without a
> second attribute, NAK to this and I'll send a more complete fix shortly.
>
> --D
Hi Darrick, Jeff

It seems that fsetxattr() with an uninitialized buffer fell into the 
following xattr_data->type
check at security/integrity/evm/evm_main.c in kernel:
----------------------------------------------------------------------------------------------------------------------------
int evm_inode_setxattr(struct dentry *dentry, const char *xattr_name,
                        const void *xattr_value, size_t xattr_value_len)
{
...
         if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
                 if (!xattr_value_len)
                         return -EINVAL;
                 if (xattr_data->type != EVM_IMA_XATTR_DIGSIG &&
                     xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG)
                         return -EPERM;
         }
...
}
----------------------------------------------------------------------------------------------------------------------------

Perhaps, we can skip this check by setting security.evm attribute to 
special value(e.g.
EVM_IMA_XATTR_DIGSIG or EVM_XATTR_PORTABLE_DIGSIG) .  For example:
---------------------------------------------------------------------------------------------------------------------
diff --git a/src/t_attr_corruption.c b/root/t_attr_corruption.c
index 1fa5e41f..05ce5b46 100644
--- a/src/t_attr_corruption.c
+++ b/root/t_attr_corruption.c
@@ -61,6 +61,7 @@ int main(int argc, char *argv[])
         ssize_t sz;
         int fd;
         int ret;
+       int eval = 0x03;

         if (argc > 1) {
                 ret = chdir(argv[1]);
@@ -76,7 +77,7 @@ int main(int argc, char *argv[])
         if (ret)
                 die("set posix acl");

-       ret = fsetxattr(fd, "security.evm", buf, 1, 1);
+       ret = fsetxattr(fd, "security.evm", &eval, sizeof(eval), 1);
---------------------------------------------------------------------------------------------------------------------

Best Regards,
Xiao Yang
>> --D
>>
>>>   	if (ret)
>>>   		die("set evm");
>>>
>>> -- 
>>> 2.16.4
>>>
>
>
